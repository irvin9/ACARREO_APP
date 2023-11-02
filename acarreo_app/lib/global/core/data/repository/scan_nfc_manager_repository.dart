import 'dart:convert';

import 'package:acarreo_app/global/core/domain/repository/scan_nfc_repository.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class ScanNFCManagerRepository implements ScanNfcRepository {
  late NFCAvailability _isAvailable;
  late NFCTag _tag;

  NFCAvailability get isAvailable => _isAvailable;

  @override
  Future<bool> isSupported() async {
    _isAvailable = await FlutterNfcKit.nfcAvailability;
    if (_isAvailable != NFCAvailability.available) {
      return false;
    }
    return true;
  }

  @override
  Future<String?> startSession({int timeout = 30}) async {
    String? tagDecode;
    bool checkSupport = await isSupported();
    if (checkSupport) {
      _tag = await FlutterNfcKit.poll(timeout: Duration(seconds: timeout))
          .timeout(Duration(seconds: timeout));
      tagDecode = _tag.id;
    }
    return tagDecode;
  }

  @override
  Future<void> stopSession() async {
    await FlutterNfcKit.finish();
  }

  @override
  Future<Map<String, dynamic>?> readNfcData() async {
    final ndefAvailable = _tag.ndefAvailable ?? false;
    if (ndefAvailable) {
      final records = await FlutterNfcKit.readNDEFRecords(cached: false);
      if (records.isNotEmpty) {
        final record = records.first;
        final payload = record.payload;
        if (payload != null) {
          String recordData = utf8.decode(payload.buffer.asInt8List().toList());
          final data = json.decode(recordData);
          return data;
        }
      }
    }
    return null;
  }

  @override
  Future<void> writeNfcData(Map<String, dynamic> data) async {
    final bool isWritable = (_tag.type == NFCTagType.mifare_ultralight ||
            _tag.type == NFCTagType.mifare_classic) &&
        _tag.ndefWritable == true;
    if (!isWritable) return;
    final jsonData = jsonEncode(data);
    await FlutterNfcKit.writeNDEFRecords([ndef.TextRecord(text: jsonData)]);
  }
}
