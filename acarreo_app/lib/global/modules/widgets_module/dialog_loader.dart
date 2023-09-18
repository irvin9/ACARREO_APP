import 'package:acarreo_app/global/modules/widgets_module/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogMessage {
  final String title;
  final String description;

  DialogMessage({required this.title, required this.description});

  factory DialogMessage.fromMap(Map<String, dynamic> message) => DialogMessage(
        title: message['title'],
        description: message['description'],
      );
}

class DialogLoader {
  static show(BuildContext context, DialogMessage message) {
    return GenericDialog.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24.0, fontWeight: FontWeight.w700),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
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
            message.description,
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
