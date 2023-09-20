import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/data_manager_service.dart';

part 'acarreo_form_state.dart';

class AcarreoFormCubit extends Cubit<AcarreoFormState> {
  AcarreoFormCubit(this.managerService) : super(const AcarreoFormInitial());

  final DataManagerService managerService;

  final Map<String, dynamic> _answers = {};
  final List<AcarreoLocation> _localLocations = [];
  final List<AcarreoMaterial> _localMaterials = [];
  final List<AcarreoTruck> _localTrucks = [];

  List<AcarreoLocation> get locations => _localLocations;

  List<AcarreoMaterial> get materials => _localMaterials;

  List<AcarreoTruck> get trucks => _localTrucks;

  getFormValues() async {
    final items = await managerService.get();
  }

  Map<String, dynamic> addAnswer(String key, dynamic value) {
    _answers.addAll({key: value});
    return _answers;
  }
}
