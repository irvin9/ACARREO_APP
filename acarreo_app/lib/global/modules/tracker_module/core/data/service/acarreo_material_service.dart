import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/material_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';

class AcarreoMaterialService implements MaterialService<AcarreoMaterial> {
  AcarreoMaterialService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.materials);
  }

  final LocalStorageService localStorageService;
  final MaterialRepository<AcarreoMaterial> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final materials =
          items.cast().map((i) => AcarreoMaterial.fromJson(i)).toList();
      return materials;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  update() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final materials = await repository.getMaterialsByClientAndProject(
        currentUser.idClient.toString(),
        currentUser.idProject.toString(),
      );
      final castMaterials = materials.map((i) => i.toJson()).toList();
      localStorageService.saveItems(castMaterials);
      return materials;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
