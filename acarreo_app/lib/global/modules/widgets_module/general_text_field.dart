import 'package:flutter/material.dart';

typedef FormsValidate = String? Function(String?)?;

class GeneralTextField extends StatelessWidget {
  final String labelText;
  final double horizontalPadding;
  final double verticalPadding;
  final Icon icon;
  final double containerTextFieldHeight;
  final double containerTextFieldPaddingTop;
  final double hintTextSize;
  final Color colorHinText;
  final FontWeight hintFontWeight;
  final String? fontFamilyHintText;
  final FormsValidate validator;

  final TextInputType? textInputType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const GeneralTextField({
    super.key,
    this.labelText = '',
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.icon = const Icon(Icons.info),
    this.containerTextFieldHeight = 0.0,
    this.containerTextFieldPaddingTop = 0.0,
    this.hintTextSize = 16.0,
    this.colorHinText = Colors.black87,
    this.hintFontWeight = FontWeight.bold,
    this.fontFamilyHintText,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return wrapperTextFormField(context);
  }

  Widget wrapperTextFormField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Container(
        height: containerTextFieldHeight,
        padding: EdgeInsets.only(left: 12.0, top: containerTextFieldPaddingTop),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            // BoxShadow(
            //   color: Colors.grey,
            //   blurRadius: 4.0,
            //   offset: Offset(-0.5, 2.3),
            // ),
          ],
        ),
        child: textFormFieldWithState(validator),
      ),
    );
  }

  Widget textFormFieldWithState(FormsValidate validator) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: labelText,
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: colorHinText,
          fontWeight: hintFontWeight,
          fontFamily: fontFamilyHintText,
          fontSize: hintTextSize,
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
