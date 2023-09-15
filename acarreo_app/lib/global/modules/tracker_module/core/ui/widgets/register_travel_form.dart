import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class RegisterTravelForm extends StatelessWidget {
  const RegisterTravelForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: const Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipo de ubicación',
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
          SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ubicación',
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
        ],
      ),
    );
  }
}



            // TextFormField(
            //   style: GoogleFonts.poppins(fontSize: 14.0),
            //   decoration: const InputDecoration(
            //     floatingLabelBehavior: FloatingLabelBehavior.never,
            //     labelText: 'Seleccione su tipo de ubicación',
            //     contentPadding: EdgeInsets.symmetric(
            //       horizontal: 12.0,
            //     ),
            //   ),
            // ),