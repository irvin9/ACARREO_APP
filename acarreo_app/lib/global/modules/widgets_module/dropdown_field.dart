import 'package:flutter/material.dart';

const defaultValue = {'': ''};

class DropdownField extends StatefulWidget {
  final String initialValue;
  final Map<String, String> options;
  final bool disable;
  final void Function(String?)? onChanged;

  const DropdownField({
    super.key,
    this.options = defaultValue,
    this.initialValue = '',
    this.onChanged,
    this.disable = false,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String seleccion = '';

  @override
  void initState() {
    super.initState();
    seleccion = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: seleccion,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
        ),
        items: widget.options.keys.map((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(widget.options[key] ?? ''),
          );
        }).toList(),
        onChanged: !widget.disable
            ? (String? newValue) {
                setState(() {
                  seleccion = newValue!;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              }
            : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
