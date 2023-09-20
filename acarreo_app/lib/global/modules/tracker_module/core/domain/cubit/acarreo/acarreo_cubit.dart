import 'package:acarreo_app/global/core/acarreo_core_module.dart';

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
    await managerService.update();
    emit(const AcarreoSuccess());
  }

  Future<void> getLocalData() async {
    await Future.delayed(Duration.zero);
    emit(const LoadingLocalData());
    final hasData = await managerService.get();
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

  Future<void> updateTickets() async {
    await Future.delayed(Duration.zero);
    emit(const AcarreoShowLoadingModal(message: {
      'title': 'Subiendo archivos pendientes',
      'description': 'Espere estamos subiendo la información pendiente...',
    }));
    emit(const AcarreoSuccess());
  }
}
