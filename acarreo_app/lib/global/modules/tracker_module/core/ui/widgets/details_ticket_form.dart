import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/custom_text_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/dropdown_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/text_field_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DetailsTicketForm extends StatelessWidget {
  static final TextEditingController folioTicketController =
      TextEditingController(text: '');

  const DetailsTicketForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AcarreoCubit>((bloc) => bloc.stream);
    folioTicketController.text = cubit.formAnswers['folio_ticket_origin'] ?? '';
    final String? answerTypeLocation = cubit.formAnswers['type_location'];
    final String? answerTypeRegister = cubit.formAnswers['type_register'];
    final truck = cubit.formAnswers['currentTruck'] as AcarreoTruck;
    final captureDate =
        DateFormat('dd/MM/yy hh:mm a').format(cubit.formAnswers['date']);

    final materials = cubit.managerService.materials
        .map((i) => {i.id.toString(): i.materialName})
        .toList();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldViewer(
              label: 'Tipo de registro',
              value: answerTypeRegister?.toUpperCase() ?? 'Desconocido'),
          TextFieldViewer(label: 'Matricula camión:', value: truck.plate),
          TextFieldViewer(label: 'Fecha de captura:', value: captureDate),
          TextFieldViewer(
              label: 'Capacidad de Carga:', value: '${truck.capacity} m3'),
          DropDownFormField(
            initialValue: cubit.formAnswers['id_material'] ?? '',
            items: materials,
            label: 'Tipo de material',
            helperMessage: DialogMessageModel(
                title: 'Tipo de material',
                description: 'Seleccione el material.'),
            onChanged: (value) => cubit.addAnswer(
                'id_material', value!.isNotEmpty ? value : null),
          ),
          Visibility(
            visible: TypeLocations.banco.toString() == answerTypeLocation &&
                FormValues.mappingTypeRegister['1'] == answerTypeRegister,
            child: CustomTextFormField(
              label: 'Folio Banco',
              placeholder: 'Ingrese el folio',
              helperMessage: DialogMessageModel(
                  title: 'Folio Banco', description: 'Ingrese el folio.'),
              initialValue: cubit.formAnswers['folio'] ?? '',
              maxLength: 6,
              maxLines: 1,
              validators: const {'NOT_NULL': '', 'MIN_LENGTH': 6},
              onChanged: (value) {
                cubit.addAnswer('folio', value);
              },
            ),
          ),
          Visibility(
            visible: FormValues.mappingTypeRegister['2'] == answerTypeRegister,
            child: CustomTextFormFieldController(
              label: 'Folio Ticket Origen',
              placeholder: 'Ingrese el folio',
              helperMessage: DialogMessageModel(
                  title: 'Escanea el folio',
                  description:
                      'Mantenga prensionado el campo para abrir la camara, despues escanee su código.'),
              controller: folioTicketController,
              readOnly: true,
              maxLength: 20,
              maxLines: 1,
              keyboardType: TextInputType.number,
              onLongPress: () => cubit.initScannerCode(),
              textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
              validators: const {'NOT_NULL': '', 'MIN_LENGTH': 20},
            ),
          ),
          CustomTextFormField(
            label: 'Comentario',
            placeholder: 'Nota de ubicación',
            helperMessage: DialogMessageModel(
                title: 'Comentario', description: 'Nota de ubicación.'),
            initialValue: cubit.formAnswers['description'] ?? '',
            maxLength: 180,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validators: const {'NOT_NULL': ''},
            onChanged: (value) {
              cubit.addAnswer('description', value);
            },
          ),
        ],
      ),
    );
  }
}
