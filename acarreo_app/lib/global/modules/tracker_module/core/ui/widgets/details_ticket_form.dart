import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/widgets_module/custom_dropdown_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/custom_text_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/dropdown_form_field.dart';
import 'package:acarreo_app/global/modules/widgets_module/text_field_viewer.dart';
import 'package:acarreo_app/global/modules/widgets_module/title_form.dart';
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
        .where((i) => i.state != "0")
        .map((i) => {i.id.toString(): i.materialName})
        .toList();

    final locationName = cubit.managerService.locations
        .firstWhere((i) => i.id.toString() == cubit.formAnswers['id_location'])
        .name;

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldViewer(
              label: 'Tipo de registro',
              value: answerTypeRegister?.toUpperCase() ?? 'Desconocido'),
          TextFieldViewer(label: 'Ubicación:', value: locationName),
          TextFieldViewer(label: 'Matricula camión:', value: truck.plate),
          TextFieldViewer(label: 'Fecha de captura:', value: captureDate),
          TextFieldViewer(
              label: 'Capacidad de Carga:', value: '${truck.capacity} m3'),
          const TitleForm(
            title: '',
            description:
                'Debes registrar los detalles de la ubicación, que se definen a continuación.',
          ),
          DropDownFormField(
            initialValue: cubit.formAnswers['id_material'] ?? '',
            items: materials,
            label: 'Tipo de material',
            helperMessage: DialogMessageModel(
                title: 'Tipo de material',
                description:
                    'Selecciona el material que transporta el camión. Si no aparece el material en el listado es necesario darlo de alta en el sistema.'),
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
                  title: 'Folio Banco',
                  description:
                      'Introduce los últimos 6 dígitos del albarán del banco de material. Si son menos de 6 dígitos completar con ceros. Ejemplo: 001234.'),
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
            visible:
                FormValues.mappingTypeRegister['2'] == answerTypeRegister &&
                    folioTicketController.value.text.isEmpty,
            child: CustomTextFormFieldController(
              label: 'Folio Ticket Origen',
              placeholder: 'Ingrese el folio',
              helperMessage: DialogMessageModel(
                  title: 'Escanea el folio',
                  description:
                      'Presione el campo para abrir la camara, despues escanee su código.'),
              controller: folioTicketController,
              readOnly: true,
              maxLength: 20,
              maxLines: 1,
              keyboardType: TextInputType.number,
              onTap: () => cubit.initScannerCode(),
              textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
              validators: const {'NOT_NULL': '', 'MIN_LENGTH': 20},
            ),
          ),
          CustomTextFormField(
            label: 'Comentario',
            placeholder: 'Nota de ubicación',
            helperMessage: DialogMessageModel(
                title: 'Comentario',
                description:
                    'Introduce información adicional del viaje (imputación de coste, unidad de obra, destino final del viaje, ruta de acarreo, incidencias, descuentos a subcontratistas…).'),
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

class DetailsTicketBankForm extends StatelessWidget {
  static final TextEditingController folioTicketController =
      TextEditingController(text: '');

  const DetailsTicketBankForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AcarreoCubit>((bloc) => bloc.stream);
    folioTicketController.text = cubit.formAnswers['folio_ticket_origin'] ?? '';

    final materials = cubit.managerService.materials
        .where((i) => i.state != "0")
        .map((i) => {i.id.toString(): i.materialName})
        .toList();

    final carries = cubit.managerService.carries
        .map((i) => {i.id.toString(): i.name})
        .toList();

    final trucks = cubit.managerService.trucks
        .map((i) => {i.id.toString(): i.plate})
        .toList();

    final companies = cubit.managerService.companies
        .map((i) => {i.id.toString(): i.name})
        .toList();

    final customers = cubit.managerService.customers
        .map((i) => {i.id.toString(): i.name})
        .toList();

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomDropdownFormField(
            dropdownLabelText: 'Transportistas',
            items: carries,
            inputPlaceholderText: 'Escriba su transportista',
            onChanged: (value) =>
                cubit.addAnswer('id_carrier', value!.isNotEmpty ? value : null),
          ),
          CustomDropdownFormField(
              dropdownLabelText: 'Camión',
              items: trucks,
              inputPlaceholderText: 'Escriba las placas',
              onChanged: (value) => cubit.addAnswer(
                  'id_truck', value!.isNotEmpty ? value : null)),
          DropDownFormField(
            initialValue: cubit.formAnswers['id_company'] ?? '',
            items: companies,
            label: 'Empresa de explotación',
            helperMessage: DialogMessageModel(
                title: 'Empresas explotadoras', description: 'n/a'),
            onChanged: (value) =>
                cubit.addAnswer('id_company', value!.isNotEmpty ? value : null),
          ),
          CustomTextFormFieldController(
            label: 'Ticket',
            placeholder: 'Ingrese el folio',
            helperMessage: DialogMessageModel(
                title: 'Escanea el folio',
                description:
                    'Presione el campo para abrir la camara, despues escanee su código.'),
            controller: folioTicketController,
            readOnly: true,
            maxLength: 20,
            maxLines: 1,
            keyboardType: TextInputType.number,
            onTap: () => cubit.initScannerCode(),
            textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          ),
          DropDownFormField(
            initialValue: cubit.formAnswers['id_customer'] ?? '',
            items: customers,
            label: 'Clientes',
            helperMessage:
                DialogMessageModel(title: 'Clientes', description: 'n/a'),
            onChanged: (value) => cubit.addAnswer(
                'id_customer', value!.isNotEmpty ? value : null),
          ),
          DropDownFormField(
            initialValue: cubit.formAnswers['id_material'] ?? '',
            items: materials,
            label: 'Tipo de material',
            helperMessage: DialogMessageModel(
                title: 'Tipo de material',
                description:
                    'Selecciona el material que transporta el camión. Si no aparece el material en el listado es necesario darlo de alta en el sistema.'),
            onChanged: (value) => cubit.addAnswer(
                'id_material', value!.isNotEmpty ? value : null),
          ),
          CustomTextFormField(
            label: 'Folio Banco',
            placeholder: 'Ingrese el folio',
            helperMessage: DialogMessageModel(
                title: 'Folio Banco',
                description:
                    'Introduce los últimos 6 dígitos del albarán del banco de material. Si son menos de 6 dígitos completar con ceros. Ejemplo: 001234.'),
            initialValue: cubit.formAnswers['folio'] ?? '',
            maxLength: 6,
            maxLines: 1,
            validators: const {'NOT_NULL': '', 'MIN_LENGTH': 6},
            onChanged: (value) {
              cubit.addAnswer('folio', value);
            },
          ),
          CustomTextFormField(
            label: 'Comentario',
            placeholder: 'Nota de ubicación',
            helperMessage: DialogMessageModel(
                title: 'Comentario',
                description:
                    'Introduce información adicional del viaje (imputación de coste, unidad de obra, destino final del viaje, ruta de acarreo, incidencias, descuentos a subcontratistas…).'),
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
