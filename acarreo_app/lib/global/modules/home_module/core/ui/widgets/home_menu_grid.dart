import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/ui/widgets/card_menu_item_grid.dart';
import 'package:flutter/material.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({
    super.key,
    required this.menu,
  });

  final List<MenuData> menu;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: menu.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) => CardMenuItemGrid(
        item: menu[index],
        action: () => Modular.to.pushNamed(menu[index].uri),
      ),
    );
  }
}
