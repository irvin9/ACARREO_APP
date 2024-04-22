import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/text_field_viewer.dart';
import 'package:flutter/material.dart';

class PreviewLocationTravel extends StatefulWidget {
  const PreviewLocationTravel({super.key});

  @override
  State<PreviewLocationTravel> createState() => _PreviewLocationTravelState();
}

class _PreviewLocationTravelState extends State<PreviewLocationTravel> {
  final cubit = Modular.get<AcarreoCubit>();

  final msgWarningDescription = 'Verifica si el tipo de registro (origen/destino)'
      'y la ubicación son correctas antes de registrar el viaje';
  final String msgWarningDescriptionBank = 'Verifica si el tipo de registro (entrada/salida de material)'
      'y la ubicación son correctas antes de registrar el viaje';
  String? answerTypeRegister;
  String? answerTypeLocation;
  String? locationName;

  @override
  void initState() {
    super.initState();
    updateView();
  }

  updateView() async {
    await cubit.getDataFirstLocation();
    setState(() {
      answerTypeRegister = cubit.formAnswers['type_register'];
      answerTypeLocation = cubit.formAnswers['type_location'];
      locationName = cubit.formAnswers['location_name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = cubit.storage.currentUser;

    return Column(
      children: [
        TextFieldViewer(
            label: 'Tipo de registro',
            value: currentUser.idModule == 0
                ? (FormValues.optionTypeRegisters[answerTypeRegister] ?? 'Desconocido')
                : (FormValues.optionTypeRegisterBanks[answerTypeRegister] ?? 'Desconocido')),
        if (answerTypeLocation != null)
          TextFieldViewer(
              label: 'Tipo de ubicación', value: FormValues.optionTypeLocations[answerTypeLocation]?.toUpperCase() ?? 'Desconocido'),
        TextFieldViewer(label: 'Ubicación', value: locationName ?? 'Desconocido'),
        TextFieldViewer(
          fontColor: Colors.redAccent,
          fontSize: 20.0,
          valueAlignText: TextAlign.center,
          label: '¡Importante!'.toUpperCase(),
          value: currentUser.idModule == 0 ? msgWarningDescription : msgWarningDescriptionBank,
        ),
      ],
    );
  }
}
