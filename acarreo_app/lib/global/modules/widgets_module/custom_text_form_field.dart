// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:acarreo_app/global/modules/widgets_module/dialog_info.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? initialValue;
  final int maxLength;
  final int? maxLines;
  final bool enable;
  final double fontSizeLabel;
  final double fontSizePlaceholder;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textInputFormatter;
  final DialogMessageModel? helperMessage;
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
    this.helperMessage,
    this.validators,
    this.keyboardType,
    this.textInputFormatter,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: fontSizeLabel,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Visibility(
              visible: helperMessage != null,
              child: IconButton(
                color: Colors.black87,
                iconSize: fontSizeLabel,
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  DialogInfo.show(context, helperMessage!);
                },
              ),
            ),
          ],
        ),
        TextFormField(
          maxLines: maxLines,
          maxLength: maxLength,
          textInputAction: TextInputAction.done,
          initialValue: initialValue,
          enabled: enable,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: GoogleFonts.poppins(
            fontSize: fontSizePlaceholder,
            fontWeight: FontWeight.w500,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => validation(value),
          inputFormatters: textInputFormatter,
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

class CustomTextFormFieldController extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final int maxLength;
  final int? maxLines;
  final bool readOnly;
  final double fontSizeLabel;
  final double fontSizePlaceholder;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textInputFormatter;
  final DialogMessageModel? helperMessage;

  final Map<String, dynamic>? validators;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomTextFormFieldController({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.controller,
    required this.maxLength,
    this.maxLines,
    this.readOnly = true,
    this.fontSizeLabel = 16.0,
    this.fontSizePlaceholder = 16.0,
    this.onChanged,
    this.onTap,
    this.helperMessage,
    this.validators,
    this.keyboardType,
    this.textInputFormatter,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: fontSizeLabel,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Visibility(
              visible: helperMessage != null,
              child: IconButton(
                color: Colors.black87,
                iconSize: fontSizeLabel,
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  DialogInfo.show(context, helperMessage!);
                },
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: onTap != null,
            child: TextFormField(
              maxLines: maxLines,
              maxLength: maxLength,
              controller: controller,
              enableInteractiveSelection: true,
              readOnly: readOnly,
              onChanged: onChanged,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(
                fontSize: fontSizePlaceholder,
                fontWeight: FontWeight.w500,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => validation(value),
              inputFormatters: textInputFormatter,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: placeholder,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
