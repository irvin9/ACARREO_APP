import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class DetailsTicketForm extends StatelessWidget {
  const DetailsTicketForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipo de material',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DropdownFormField(
                options: FormValues.optionTypeTravels,
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ubicación destino',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DropdownFormField(
                options: FormValues.optionTravels,
              ),
            ],
          ),
          // const SizedBox(height: 24.0),
          // const Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       'Tipo de ruta',
          //       textAlign: TextAlign.start,
          //       style: TextStyle(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     DropdownFormField(
          //       options: FormValues.optionTravels,
          //     ),
          //   ],
          // ),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Comentario',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                maxLines: null,
                maxLength: 180,
                enabled: false,
                keyboardType: TextInputType.multiline,
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Nota de ubicación',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
