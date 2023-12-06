import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DialogInfo {
  static show(BuildContext context, DialogMessageModel message) {
    return GenericDialog.show(
      dismissible: true,
      context: context,
      child: AlertDialog(
        icon: const Icon(Icons.info_outline_rounded,
            size: 48, color: Colors.black87),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 20.0, fontWeight: FontWeight.w700),
            ).withPaddingOnly(bottom: 12),
            Text(
              message.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
