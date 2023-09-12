import 'package:acarreo_app/acarreo_app.dart';
import 'package:acarreo_app/global/acarreo_app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(
    ModularApp(
      module: AcarreoAppModule(),
      child: const AcarreoApp(),
    ),
  );
}
