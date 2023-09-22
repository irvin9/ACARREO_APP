import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class TextFieldViewer extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final double padding;
  final CrossAxisAlignment crossAxisAlignment;

  const TextFieldViewer({
    super.key,
    required this.label,
    required this.value,
    this.fontSize = 16.0,
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
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ).withPaddingSymmetric(vertical: padding, horizontal: 0.0);
  }
}
