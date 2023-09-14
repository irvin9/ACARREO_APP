import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TittleScreen extends StatelessWidget {
  final String tittleText;

  const TittleScreen({super.key, required this.tittleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.only(left: 20.0),
      height: 26,
      width: double.infinity,
      child: Text(
        tittleText,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 24.0,
            color: Colors.black87,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
