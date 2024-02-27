import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_customer.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/customer_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/customer_service.dart';

class AcarreoCustomerService implements CustomerService<AcarreoCustomer> {
  AcarreoCustomerService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.customers);
  }

  final LocalStorageService localStorageService;
  final CustomerRepository<AcarreoCustomer> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final customers =
          items.cast().map((i) => AcarreoCustomer.fromJson(i)).toList();
      return customers;
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

      final customers = await repository.getCustomersByParams(filterParams);
      final castCustomers = customers.map((l) => l.toJson()).toList();
      localStorageService.saveItems(castCustomers);
      return customers;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
