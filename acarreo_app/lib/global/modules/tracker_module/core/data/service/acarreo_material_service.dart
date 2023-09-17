import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/material_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';
import 'package:flutter/foundation.dart';

class AcarreoMaterialService implements MaterialService {
  final MaterialRepository<AcarreoMaterial> repository;
  final StorageService storage;

  AcarreoMaterialService({required this.storage, required this.repository});

  @override
  getMaterials() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final materials = await repository.getMaterialsByClientAndProject(
        currentUser.idClient.toString(),
        currentUser.idProject.toString(),
      );
      return materials;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
