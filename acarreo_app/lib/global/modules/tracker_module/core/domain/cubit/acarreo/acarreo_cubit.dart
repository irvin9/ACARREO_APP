import 'dart:math';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:intl/intl.dart';

class AcarreoCubit extends Cubit<AcarreoState> {
  AcarreoCubit(this.managerService) : super(const AcarreoInitState());

  final AcarreoDataManagerService managerService;

  final Map<String, dynamic> _formAnswers = {};
  bool _pendingTickets = false;

  Map<String, dynamic> get formAnswers => _formAnswers;

  bool get pedingTickets => _pendingTickets;

  Future<void> updateLocalData() async {
    await Future.delayed(Duration.zero);
    emit(const AcarreoShowLoadingModal(message: {
      'title': 'Cargando nueva información',
      'description': 'Espere estamos cargando nueva información a su cuenta...',
    }));
    final success = await managerService.update();
    if (success) {
      emit(const AcarreoSuccess());
    } else {
      emit(const AcarreoError({
        'title': '¡Ocurrio un error!',
        'description':
            'Una disculpa, no hemos podido completar la petición, vuelva intentarlo.',
      }));
    }
  }

  void clearAnswers() async {
    await Future.delayed(Duration.zero);
    emit(const AcarreoInitState());
    _formAnswers.clear();
    emit(FormChangedValue(_formAnswers));
  }

  Future<void> getLocalData() async {
    await Future.delayed(Duration.zero);
    emit(const LoadingLocalData());
    final hasData = await managerService.get();
    _pendingTickets = await managerService.hasPeddingTickes();
    if (!hasData) {
      updateLocalData();
    }
    emit(const LocalDataSuccess());
  }

  void addAnswer(String key, dynamic value) {
    final newValue = {key: value};
    emit(SettingNewValueToForm(newValue));
    _formAnswers.addAll({key: value});
    emit(FormChangedValue(_formAnswers));
  }

  dynamic getAnswersForm(String key) {
    return _formAnswers[key];
  }

  Future<void> createTicket() async {
    await Future.delayed(Duration.zero);
    emit(const AcarreoInitCreateTicket());
    final truck = _formAnswers['currentTruck'] as AcarreoTruck;
    _formAnswers['id_client'] = truck.idClient;
    _formAnswers['id_project'] = truck.idProject;
    _formAnswers['id_truck'] = truck.id;
    final ticket = AcarreoTicket.fromForm(_formAnswers);
    final success = await managerService.ticketService.createTicket(ticket);
    if (success != null) {
      _pendingTickets = true;
      emit(const AcarreoShowModalTicketPrint());
      return;
    }
    _pendingTickets = false;
    emit(const AcarreoError({
      'title': 'Error al crear ticket',
      'description': 'No hemos podido crear tu ticket.'
    }));
  }

  Future<void> updateTickets() async {
    await Future.delayed(Duration.zero);
    if (!_pendingTickets) return;
    emit(const AcarreoShowLoadingModal(message: {
      'title': 'Subiendo archivos pendientes',
      'description': 'Espere estamos subiendo la información pendiente...',
    }));
    final tickets = await managerService.ticketService.get() ?? [];

    for (var ticket in tickets) {
      final newTicket = await managerService.ticketService.uploadTicket(ticket);
      if (newTicket == null) {
        _pendingTickets = true;
        emit(const AcarreoError({
          'title': 'Ha ocurrido un error',
          'description': 'No hemos podido terminar la carga de tickets, '
              'intente más tarde'
        }));
        return;
      }
    }
    _pendingTickets = false;
    emit(const AcarreoSuccess());
  }

  String generateTicketCode() {
    final DateTime captureDate = _formAnswers['date'];
    String dateFormatted =
        "${captureDate.year.toString().substring(2)}${captureDate.month.toString().padLeft(2, '0')}${captureDate.day}";
    final String truckId =
        int.parse((_formAnswers['truckId'] ?? '0').toString())
            .toString()
            .padLeft(4, '0'); // (PROGRESO)(NORDIC MERCHANTS)
    String hourFormatted =
        '${captureDate.hour.toString().padLeft(2, '0')}${captureDate.minute.toString().padLeft(2, '0')}${captureDate.second.toString().padLeft(2, '0')}';
    String scannerId = _generateScannerId();

    String ticketCode = '$dateFormatted$truckId$hourFormatted$scannerId';
    addAnswer('folioId', ticketCode);
    return ticketCode;
  }

  String _generateScannerId() {
    final random = Random();
    int numeroAleatorio = random.nextInt(9999) + 1;
    return numeroAleatorio.toString().padLeft(4, '0');
  }

  Map<String, dynamic> formatTicket() {
    final project = managerService.project;
    final String description = formAnswers['description'] ?? '';
    final truck = formAnswers['currentTruck'] as AcarreoTruck;
    final int materialId = int.parse(getAnswersForm('id_material'));
    final material =
        managerService.materials.firstWhere((item) => materialId == item.id);
    final int locationId = int.parse(getAnswersForm('id_location'));
    final location =
        managerService.locations.firstWhere((item) => item.id == locationId);
    final captureDate =
        DateFormat('dd/MM/yy hh:mm a').format(formAnswers['date']);
    final String ticketCode = formAnswers['folioId'];

    return {
      'enterpriseName': project?.enterpriseName ?? 'N/A',
      'projectName': project?.projectName ?? 'N/A',
      'date': captureDate,
      'location': location.name,
      'material': material.materialName,
      'plates': truck.plate,
      'capacity': truck.capacity,
      'description': description,
      'barcode': ticketCode,
    };
  }

  Future<void> goTo(String route) {
    return Modular.to.pushNamedAndRemoveUntil(route, (p0) => false);
  }

  finishForm(String route) async {
    clearAnswers();
    await goTo(route);
    emit(const AcarreoInitState());
  }

  Future<void> initScannerCode() async {
    emit(const FormInitScanner());
    final code = await managerService.readScanner();
    if (code != null) {
      addAnswer('folio_ticket', code);
      emit(FormScannerSuccess(code));
      return;
    }
    emit(const FormScannerError());
  }
}
