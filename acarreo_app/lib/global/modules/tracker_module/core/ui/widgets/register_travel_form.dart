import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/dropdown_form_field.dart';
import 'package:flutter/material.dart';

class RegisterTravelForm extends StatelessWidget {
  const RegisterTravelForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AcarreoCubit>((bloc) => bloc.stream);

    final String? answerTypeLocation = bloc.formAnswers['type_location'];

    final locations = bloc.managerService.locations
        .where((l) => l.idLabel.toString() == answerTypeLocation)
        .map((i) => {i.id.toString(): i.name})
        .toList();

    return Form(
      key: formKey,
      child: Column(
        children: [
          DropDownFormField(
            padding: 0.0,
            initialValue: bloc.formAnswers['type_register'] ?? '',
            label: 'Tipo de Registro',
            disable: bloc.formAnswers['type_location'] != null ||
                bloc.formAnswers['id_location'] != null,
            items: const [FormValues.optionTypeRegisters],
            onChanged: (value) => bloc.addAnswer(
                'type_register', value!.isNotEmpty ? value : null),
          ),
          const SizedBox(height: 24.0),
          DropDownFormField(
            padding: 0.0,
            initialValue: bloc.formAnswers['type_location'] ?? '',
            label: 'Tipo de ubicación',
            disable: bloc.formAnswers['type_register'] == null ||
                bloc.formAnswers['id_location'] != null,
            items: const [FormValues.optionTypeLocations],
            onChanged: (value) => bloc.addAnswer(
                'type_location', value!.isNotEmpty ? value : null),
          ),
          const SizedBox(height: 24.0),
          DropDownFormField(
            padding: 0.0,
            initialValue: bloc.formAnswers['id_location'] ?? '',
            label: 'Ubicación',
            disable: bloc.formAnswers['type_register'] == null ||
                bloc.formAnswers['type_location'] == null,
            items: locations,
            onChanged: (value) =>
                bloc.addAnswer('id_location', value!.isNotEmpty ? value : null),
          ),
        ],
      ),
    );
  }
}
