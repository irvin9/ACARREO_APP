import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class FilterParams extends Equatable {
  final int idClient;
  final int idProject;
  final int idModule;

  const FilterParams({
    required this.idClient,
    required this.idProject,
    required this.idModule,
  });

  Map<String, String> get toMap => {
        "id_client": idClient.toString(),
        "id_project": idProject.toString(),
        "id_module": idModule.toString(),
      };

  @override
  List<Object?> get props => [idClient, idProject, idModule];
}
