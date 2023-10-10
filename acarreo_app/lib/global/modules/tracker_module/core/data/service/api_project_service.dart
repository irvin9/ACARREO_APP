import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/api_project_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/project_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/project_service.dart';

class ApiProjectService implements ProjectService<ApiProjectModel> {
  ApiProjectService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.projects);
  }

  final LocalStorageService localStorageService;
  final ProjectRepository<ApiProjectModel> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final projects =
          items.cast().map((i) => ApiProjectModel.fromJson(i)).toList();
      return projects;
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
      final projects =
          await repository.getProjectsByClient(currentUser.idClient.toString());
      final castProjects = projects.map((i) => i.toMap()).toList();
      localStorageService.saveItems(castProjects);
      return projects;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  updateProject() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final project =
          await repository.getByProjectCode(currentUser.idProject.toString());
      localStorageService.saveBykey(
          project.projectCode.toString(), project.toMap());
      return project;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  Future<ApiProjectModel?> getProject() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final projectId = currentUser.idProject;
      final item = await localStorageService.getByKey(projectId.toString());
      if (item == null) return null;
      final Map<String, dynamic> project = item.cast();
      return ApiProjectModel.fromMap(project);
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
