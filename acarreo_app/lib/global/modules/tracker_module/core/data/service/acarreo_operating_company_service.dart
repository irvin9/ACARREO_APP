import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_operating_company.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/operating_company_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/operating_company_service.dart';

class AcarreoOperatingCompanyService
    implements OperatingCompanyService<AcarreoOperatingCompany> {
  AcarreoOperatingCompanyService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.customers);
  }

  final LocalStorageService localStorageService;
  final OperatingCompanyRepository<AcarreoOperatingCompany> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final companies =
          items.cast().map((i) => AcarreoOperatingCompany.fromJson(i)).toList();
      return companies;
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

      final filterParams = FilterParams(
        idClient: currentUser.idClient,
        idProject: currentUser.idProject,
        idModule: currentUser.idModule,
      );

      final companies =
          await repository.getOperatingCompaniesByParams(filterParams);
      final castCompanies = companies.map((l) => l.toJson()).toList();
      localStorageService.saveItems(castCompanies);
      return companies;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
