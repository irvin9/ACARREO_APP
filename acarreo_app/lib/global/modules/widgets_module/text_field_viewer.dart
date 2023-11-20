import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldViewer extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final Color? fontColor;
  final double valueFontSize;
  final TextAlign? valueAlignText;
  final double padding;
  final CrossAxisAlignment crossAxisAlignment;

  const TextFieldViewer({
    super.key,
    required this.label,
    required this.value,
    this.fontSize = 16.0,
    this.fontColor,
    this.valueFontSize = 16.0,
    this.valueAlignText,
    this.padding = 12.0,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: fontColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          textAlign: valueAlignText,
          style: TextStyle(
            fontSize: valueFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ).withPaddingSymmetric(vertical: padding, horizontal: 0.0);
  }
}
