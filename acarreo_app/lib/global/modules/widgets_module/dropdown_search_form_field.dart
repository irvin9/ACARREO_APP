import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownSearchFormField extends StatefulWidget {
  const DropdownSearchFormField({
    this.dropdownLabelText,
    required this.items,
    this.inputPlaceholderText,
    required this.onChanged,
    this.initialValue,
    this.inputLabelText,
    this.showInputManual = false,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.padding = 24.0,
    this.helperMessage,
    this.disable = false,
    super.key,
  });

  final bool disable;
  final String? dropdownLabelText;
  final double fontSize;
  final FontWeight fontWeight;
  final DialogMessageModel? helperMessage;
  final String? initialValue;
  final String? inputLabelText;
  final String? inputPlaceholderText;
  final List<Map<String, String>> items;
  final Function(String?) onChanged;
  final double padding;
  final bool showInputManual;
  final TextAlign? textAlign;

  @override
  State<DropdownSearchFormField> createState() =>
      _DropdownSearchFormFieldState();
}

class _DropdownSearchFormFieldState extends State<DropdownSearchFormField> {
  static final _defaultValue = {'': 'Selecciona una opción'};

  Map<String, String>? dropdownValue = _defaultValue;
  bool showTextField = false;

  @override
  void initState() {
    super.initState();
    widget.items.insert(0, _defaultValue);
    if (widget.showInputManual) {
      widget.items.insert(1, {'manual': 'Ingresar manualmente'});
    }

    final currentIndexValue =
        widget.items.indexWhere((i) => i.keys.first == widget.initialValue);
    if (currentIndexValue != -1) {
      dropdownValue = widget.items[currentIndexValue];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.dropdownLabelText != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.dropdownLabelText!,
                  textAlign: widget.textAlign,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                  ),
                ),
              ),
              Visibility(
                visible: widget.helperMessage != null,
                child: IconButton(
                  color: Colors.black87,
                  iconSize: widget.fontSize,
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    DialogInfo.show(context, widget.helperMessage!);
                  },
                ),
              ),
            ],
          ),
        DropdownSearch<Map<String, String>>(
          selectedItem: dropdownValue,
          items: widget.items,
          itemAsString: (item) => item.values.first,
          popupProps: const PopupProps.menu(
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                hintText: "Buscar placa...",
              ),
            ),
            searchDelay: Duration(milliseconds: 500),
            showSearchBox: true,
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty || value.keys.first.isEmpty) {
              return '';
            }
            return null;
          },
          dropdownDecoratorProps: const DropDownDecoratorProps(
            baseStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            dropdownSearchDecoration: InputDecoration(
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12.0, top: 10.0),
            ),
          ), // label: widget.dropdownLabelText,
          onChanged: (value) {
            if (value == null || value.isEmpty) return;
            setState(() {
              dropdownValue = value;
              widget.onChanged(value.keys.first);
              showTextField = value.keys.first == 'manual';
            });
          },
        ),
        if (showTextField)
          CustomTextFormField(
            label: widget.inputLabelText,
            placeholder: widget.inputPlaceholderText ?? '',
            maxLength: 124,
            maxLines: 1,
            validators: const {'NOT_NULL': '', 'MIN_LENGTH': 1},
            onChanged: (value) => widget.onChanged(value),
          ),
      ],
    );
  }
}
