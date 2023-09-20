import 'dart:convert';

import 'package:acarreo_app/global/core/domain/repository/scan_nfc_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:flutter/material.dart';
import 'package:nfc_manager/platform_tags.dart';

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
          final nfca = NfcA.from(tag);
          if (nfca == null) return;
          tagDecode = await _onTagDiscovered(tag);
          stopSession();
        },
        onError: (error) async {
          debugPrint('Exception on -> ${runtimeType.toString()}');
          debugPrint(error.message);
        },
      );

      await Future.delayed(Duration(seconds: timeout), () {
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
      final nfca = NfcA.from(tag);
      if (nfca == null) {
        debugPrint('No NDEF tag');
        throw Exception('No NDEF tag');
      }

      final data = nfca.identifier;
      debugPrint(data.toString());
      final dataDecode = String.fromCharCodes(data);
      debugPrint('Data read: $dataDecode');
      return dataDecode;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
