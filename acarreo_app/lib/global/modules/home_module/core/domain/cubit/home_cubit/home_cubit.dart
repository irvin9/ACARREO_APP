import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final StorageService storage;

  HomeCubit(this.storage) : super(HomeInitial());

  Future<void> getMenuItems() async {
    emit(HomeLoadData());
    final user = await storage.getCurrentUser();
    List<MenuData> items = [
      MenuData(Icons.move_to_inbox_outlined, 'Registrar Acarreos',
          GlobalRoutesApp.registerTravelRoute),
    ];
    if (user.idModule == 1) {
      items = [
        MenuData(Icons.find_in_page_outlined, 'Registrar Bancos',
            GlobalRoutesApp.registerTravelRoute)
      ];
    }
    emit(HomeDataSuccess(menu: items));
  }
}
