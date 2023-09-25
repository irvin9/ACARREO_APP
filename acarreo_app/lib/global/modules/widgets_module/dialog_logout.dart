import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/generic_dialog.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DialogLogout {
  static show(BuildContext context, DialogMessageModel message,
      void Function()? onAction, void Function()? onBack) {
    return GenericDialog.show(
      context: context,
      child: AlertDialog(
        icon: const Icon(Icons.info, size: 60, color: Colors.orangeAccent),
        actions: [
          GeneralButton(
            buttonText: 'Confirmar',
            textColor: Colors.black87,
            onPressed: onAction,
          ),
          const SizedBox(height: 10.0),
          GeneralButton(
            buttonText: 'Cancelar',
            textColor: Colors.white,
            buttonColor: Colors.black87,
            onPressed: onBack,
          ),
        ],
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

  static hide(context) {
    GenericDialog.hide(context);
  }
}
