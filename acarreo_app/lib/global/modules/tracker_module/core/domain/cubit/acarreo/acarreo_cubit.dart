import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_state.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/data_manager_service.dart';

class AcarreoCubit extends Cubit<AcarreoState> {
  final Map<String, dynamic> formAnswers = {};

  final DataManagerService managerService;

  AcarreoCubit(this.managerService) : super(const AcarreoInitState());

  Future<void> getAcarreoData() async {
    await Future.delayed(Duration.zero);
    emit(const AcarreoShowLoadingModal(message: {
      'title': 'Cargando nueva información',
      'description': 'Espere estamos cargando nueva información a su cuenta...',
    }));
    await managerService.getData();
    emit(const AcarreoSuccess());
  }

  Future<void> updateTickets() async {
    await Future.delayed(Duration.zero);
    emit(const AcarreoShowLoadingModal(message: {
      'title': 'Subiendo archivos pendientes',
      'description': 'Espere estamos subiendo la información pendiente...',
    }));
    await managerService.getData();
    emit(const AcarreoSuccess());
  }
}
