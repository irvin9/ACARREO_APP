import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class MenuItemGrid extends StatelessWidget {
  const MenuItemGrid({super.key, required this.item, required this.action});

  final VoidCallback action;
  final MenuData item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 36,
          ),
          const SizedBox(height: 20),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          )
        ],
      ).withPaddingSymmetric(),
    );
  }
}
