import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final String dropdownLabelText;
  final String? inputLabelText;
  final String inputPlaceholderText;
  final Function(String?) onChanged;

  final List<Map<String, String>> items;

  const CustomDropdownFormField({
    super.key,
    required this.dropdownLabelText,
    required this.items,
    this.inputLabelText,
    required this.inputPlaceholderText,
    required this.onChanged,
  });

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String dropdownValue = '';
  bool showTextField = false;

  @override
  void initState() {
    super.initState();
    widget.items.insert(0, {'manual': 'Ingresar manualmente'});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownFormField(
          items: widget.items,
          label: widget.dropdownLabelText,
          onChanged: (value) {
            setState(() {
              dropdownValue = value!;
              showTextField = value == 'manual';
            });
          },
        ),
        if (showTextField)
          CustomTextFormField(
            label: widget.inputLabelText,
            placeholder: widget.inputPlaceholderText,
            maxLength: 124,
            maxLines: 1,
            validators: const {'NOT_NULL': '', 'MIN_LENGTH': 1},
            onChanged: (value) => widget.onChanged(value),
          ),
      ],
    );
  }
}
