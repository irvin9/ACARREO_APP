import 'dart:convert';

import 'package:acarreo_app/global/core/domain/repository/scan_nfc_repository.dart';
import 'package:flutter/foundation.dart';
// import 'package:nfc_manager/nfc_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:nfc_manager/platform_tags.dart';

class ScanNFCManagerRepository implements ScanNfcRepository {
  late NFCAvailability _isAvailable;

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
      final tag = await FlutterNfcKit.poll(timeout: Duration(seconds: timeout))
          .timeout(Duration(seconds: timeout));
      tagDecode = tag.id;
      await stopSession();
    }
    return tagDecode;
  }

  @override
  Future<void> stopSession() async {
    await FlutterNfcKit.finish();
  }
}
