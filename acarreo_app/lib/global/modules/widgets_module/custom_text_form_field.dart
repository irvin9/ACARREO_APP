// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? initialValue;
  final int maxLength;
  final int? maxLines;
  final bool enable;
  final double fontSizeLabel;
  final double fontSizePlaceholder;
  final Map<String, dynamic>? validators;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.initialValue,
    required this.maxLength,
    this.maxLines,
    this.enable = true,
    this.fontSizeLabel = 16.0,
    this.fontSizePlaceholder = 16.0,
    this.onChanged,
    this.validators,
  }) : super(key: key);

  String? validation(String? value) {
    if (validators == null) return null;
    if (validators!.containsKey('NOT_NULL')) {
      if (value == null || value.isEmpty) return '';
    }
    if (validators!.containsKey('MIN_LENGTH')) {
      final min = validators!['MIN_LENGTH']!;
      if (value == null || value.length < min) return '';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: fontSizeLabel,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          maxLength: maxLength,
          initialValue: initialValue,
          enabled: true,
          onChanged: onChanged,
          keyboardType: TextInputType.multiline,
          style: GoogleFonts.poppins(
            fontSize: fontSizePlaceholder,
            fontWeight: FontWeight.w500,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => validation(value),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: placeholder,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
