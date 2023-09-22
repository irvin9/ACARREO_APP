import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/custom_text_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/dropdown_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/text_field_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsTicketForm extends StatelessWidget {
  const DetailsTicketForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AcarreoCubit>((bloc) => bloc.stream);
    final truck = bloc.formAnswers['currentTruck'] as AcarreoTruck;
    final captureDate =
        DateFormat('dd/MM/yy hh:mm a').format(bloc.formAnswers['date']);

    final materials = bloc.managerService.materials
        .map((i) => {i.id.toString(): i.materialName})
        .toList();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldViewer(label: 'Matricula camión:', value: truck.plate),
          TextFieldViewer(label: 'Fecha de captura:', value: captureDate),
          TextFieldViewer(
              label: 'Capacidad de Carga:', value: '${truck.capacity} m3'),
          DropDownFormField(
            initialValue: bloc.formAnswers['id_material'] ?? '',
            items: materials,
            label: 'Tipo de material',
            onChanged: (value) =>
                bloc.addAnswer('id_material', value!.isNotEmpty ? value : null),
          ),
          CustomTextFormField(
            label: 'Folio Banco',
            placeholder: 'Ingrese el folio',
            maxLength: 6,
            maxLines: 1,
            validators: const {'NOT_NULL': '', 'MIN_LENGTH': 6},
            onChanged: (value) {
              bloc.addAnswer('folio', value);
            },
          ),
          CustomTextFormField(
            label: 'Comentario',
            placeholder: 'Nota de ubicación',
            maxLength: 180,
            maxLines: null,
            validators: const {'NOT_NULL': ''},
            onChanged: (value) {
              bloc.addAnswer('description', value);
            },
          ),
        ],
      ),
    );
  }
}
