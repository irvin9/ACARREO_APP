import 'dart:convert';

import 'package:acarreo_app/global/core/domain/repository/scan_nfc_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ScanNFCManagerRepository implements ScanNfcRepository {
  bool _isAvailable = false;

  bool get isAvailable => _isAvailable;

  @override
  Future<bool> isSupported() async {
    _isAvailable = await NfcManager.instance.isAvailable();
    return isAvailable;
  }

  @override
  Future<String?> startSession({int timeout = 30}) async {
    String? tagDecode;
    bool checkSupport = await isSupported();
    if (checkSupport) {
      NfcManager.instance.startSession(
        onDiscovered: (tag) async {
          tagDecode = await _onTagDiscovered(tag);
          stopSession();
        },
        onError: (error) async {
          debugPrint('Exception on -> ${runtimeType.toString()}');
          debugPrint(error.message);
        },
      );

      Future.delayed(Duration(seconds: timeout), () {
        stopSession();
      });
    }
    return tagDecode;
  }

  @override
  void stopSession() {
    NfcManager.instance.stopSession();
  }

  Future<String?> _onTagDiscovered(tag) async {
    try {
      final ndef = Ndef.from(tag);
      if (ndef == null) throw Exception('No NDEF tag');
      final data = await ndef.read();
      final dataDecode = utf8.decode(data.records.first.payload).substring(3);
      debugPrint(dataDecode.toString());
      return dataDecode;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
