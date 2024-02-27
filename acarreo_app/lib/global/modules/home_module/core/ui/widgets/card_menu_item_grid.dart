import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/ui/widgets/menu_item_grid.dart';
import 'package:flutter/material.dart';

class CardMenuItemGrid extends StatelessWidget {
  const CardMenuItemGrid({super.key, required this.item, required this.action});

  final VoidCallback action;
  final MenuData item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: MenuItemGrid(
        item: item,
        action: action,
      ),
    );
  }
}
