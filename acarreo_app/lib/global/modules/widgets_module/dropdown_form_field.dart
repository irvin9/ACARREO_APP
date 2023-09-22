import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class DropDownFormField extends StatelessWidget {
  final String label;
  final List<Map<String, String>> items;
  final String initialValue;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final double padding;
  final Function(String?)? onChanged;

  const DropDownFormField({
    super.key,
    required this.items,
    required this.label,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.padding = 24.0,
    this.onChanged,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        DropdownField(
          initialValue: initialValue,
          options: foldItems(),
          onChanged: onChanged,
        ),
      ],
    ).withPaddingSymmetric(vertical: padding, horizontal: 0.0);
  }

  foldItems() {
    final defaultValue = {'': 'Selecciona una opción'};
    return items.fold<Map<String, String>>(
      defaultValue,
      (previousValue, element) {
        previousValue.addAll(element);
        return previousValue;
      },
    );
  }
}
