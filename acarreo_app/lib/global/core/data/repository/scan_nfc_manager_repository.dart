import 'dart:convert';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
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
      _tag = await FlutterNfcKit.poll();
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
      try {
        final records = await FlutterNfcKit.readNDEFRecords(cached: false);
        if (records.isNotEmpty) {
          final record = records.first as ndef.TextRecord;
          final recordData = record.text;
          if (recordData?.isNotEmpty == true) {
            final data = json.decode(recordData!);
            debugPrint('${runtimeType.toString()} ReadNFCData -> $recordData');
            return data;
          }
        }
      } catch (e, s) {
        debugPrint('${runtimeType.toString()} ${e.toString()}');
        debugPrintStack(stackTrace: s);
      }
    }
    return null;
  }

  @override
  Future<bool> writeNfcData(Map<String, dynamic> data) async {
    final bool isWritable = (_tag.type == NFCTagType.mifare_ultralight || _tag.type == NFCTagType.mifare_classic || _tag.type == NFCTagType.unknown) && _tag.ndefWritable == true;
    if (!isWritable) return false;
    final jsonData = jsonEncode(data);
    debugPrint('${runtimeType.toString()} WriteNFCData -> $jsonData');
    await FlutterNfcKit.writeNDEFRecords([ndef.TextRecord(text: jsonData, language: "en")]);
    return true;
  }
}
