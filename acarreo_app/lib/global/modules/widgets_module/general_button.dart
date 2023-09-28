import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralButton extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final double fontSize;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final double buttonElevation;
  final double borderRadius;
  final double height;
  final bool isLoading;
  final VoidCallback? onPressed;

  const GeneralButton({
    Key? key,
    this.height = 54.0,
    this.borderRadius = 12.0,
    this.fontSize = 20,
    this.onPressed,
    this.horizontal = 0.0,
    this.vertical = 0.0,
    this.textColor = Colors.white,
    this.buttonColor = Colors.white,
    this.buttonText = '',
    this.buttonElevation = 0.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final button = Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(buttonElevation),
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            minimumSize:
                MaterialStateProperty.all(Size(double.infinity, height)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ))),
        child: !isLoading
            ? Text(
                buttonText,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              )
            : CircularProgressIndicator(color: textColor),
      ),
    );

    return button;
  }
}
