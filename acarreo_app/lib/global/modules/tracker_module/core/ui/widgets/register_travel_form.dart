import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
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
    final bloc = context.watch<AcarreoCubit>((bloc) => bloc.stream);
    final locations = bloc.managerService.locations
        .map((i) => {i.id.toString(): i.name})
        .toList();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tipo de ubicación',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DropdownFormField(
                options: FormValues.optionTypeTravels,
                onChanged: (value) => bloc.addAnswer('type_location', value),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ubicación',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DropdownFormField(
                options: locations.fold({'': 'Selecciona una opción'},
                    (previousValue, element) {
                  previousValue.addAll(element);
                  return previousValue;
                }),
                onChanged: (value) => bloc.addAnswer('id_location', value),
              ),
            ],
          )
        ],
      ),
    );
  }
}
