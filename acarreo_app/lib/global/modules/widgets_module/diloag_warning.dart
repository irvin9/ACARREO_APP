import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DialogWarning {
  static show(BuildContext context, IconData? icon, DialogMessageModel message,
      String? textbutton, void Function()? onAction) {
    return GenericDialog.show(
      context: context,
      child: AlertDialog(
        icon: Icon(icon ?? Icons.info, size: 60, color: Colors.orangeAccent),
        actions: [
          GeneralButton(
            buttonText: textbutton ?? 'Continuar',
            textColor: Colors.black87,
            onPressed: onAction,
          ).withPaddingOnly(top: 0, left: 0, right: 0),
          GeneralButton(
            buttonText: 'Regresar',
            textColor: Colors.black87,
            onPressed: () => hide(context),
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
