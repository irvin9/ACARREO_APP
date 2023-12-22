import 'package:acarreo_app/global/core/acarreo_core_module.dart';
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
    final cubit = context.watch<AcarreoCubit>((bloc) => bloc.stream);
    final String? answerTypeLocation = cubit.formAnswers['type_location'];
    final locations = cubit.managerService.locations
        .where((l) => l.idLabel.toString() == answerTypeLocation)
        .where((i) => i.state != 0)
        .map((i) => {i.id.toString(): i.name})
        .toList();

    return Form(
      key: formKey,
      child: Column(
        children: [
          DropDownFormField(
            padding: 0.0,
            initialValue: cubit.formAnswers['type_register'] ?? '',
            label: 'Tipo de Registro',
            disable: cubit.formAnswers['type_location'] != null ||
                cubit.formAnswers['id_location'] != null,
            items: const [FormValues.optionTypeRegisters],
            onChanged: (value) => cubit.addAnswer(
                'type_register', value!.isNotEmpty ? value : null),
          ),
          const SizedBox(height: 24.0),
          DropDownFormField(
            padding: 0.0,
            initialValue: cubit.formAnswers['type_location'] ?? '',
            label: 'Tipo de ubicación',
            disable: cubit.formAnswers['type_register'] == null ||
                cubit.formAnswers['id_location'] != null,
            items: const [FormValues.optionTypeLocations],
            onChanged: (value) => cubit.addAnswer(
                'type_location', value!.isNotEmpty ? value : null),
          ),
          const SizedBox(height: 24.0),
          DropDownFormField(
            padding: 0.0,
            initialValue: cubit.formAnswers['id_location'] ?? '',
            label: 'Ubicación',
            disable: cubit.formAnswers['type_register'] == null ||
                cubit.formAnswers['type_location'] == null,
            items: locations,
            onChanged: (value) => cubit.addAnswer(
                'id_location', value!.isNotEmpty ? value : null),
          ),
        ],
      ),
    );
  }
}

class RegisterTravelBankForm extends StatelessWidget {
  const RegisterTravelBankForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AcarreoCubit>((bloc) => bloc.stream);
    final currentUser = cubit.storage.currentUser;
    final locations = cubit.managerService.locations
        .where((i) => i.state != 0)
        .map((i) => {i.id.toString(): i.name})
        .toList();

    return Form(
      key: formKey,
      child: Column(
        children: [
          DropDownFormField(
            padding: 0.0,
            initialValue: cubit.formAnswers['type_register'] ?? '',
            label: 'Tipo de Registro',
            disable: cubit.formAnswers['id_location'] != null,
            items: currentUser.idModule == 0
                ? [FormValues.optionTypeRegisters]
                : [FormValues.optionTypeRegisterBanks],
            onChanged: (value) => cubit.addAnswer(
                'type_register', value!.isNotEmpty ? value : null),
          ),
          const SizedBox(height: 24.0),
          DropDownFormField(
            padding: 0.0,
            initialValue: cubit.formAnswers['id_location'] ?? '',
            label: 'Ubicación',
            disable: cubit.formAnswers['type_register'] == null,
            items: locations,
            onChanged: (value) => cubit.addAnswer(
                'id_location', value!.isNotEmpty ? value : null),
          ),
        ],
      ),
    );
  }
}
