import 'package:acarreo_app/global/modules/widgets_module/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogLoader {
  static show(context) {
    return GenericDialog.show(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cargando nueva información',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24.0, fontWeight: FontWeight.w700),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            // color: Colors.white70,
            child: const Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: FittedBox(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                    strokeWidth: 5,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Espere estamos cargando nueva información a su cuenta...',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  static hide(context) {
    GenericDialog.hide(context);
  }
}
