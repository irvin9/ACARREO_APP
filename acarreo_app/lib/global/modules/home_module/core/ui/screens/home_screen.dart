import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/domain/cubit/home_cubit/home_cubit.dart';
import 'package:acarreo_app/global/modules/home_module/core/ui/widgets/home_menu_grid.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF151A20),
        image: DecorationImage(
          isAntiAlias: true,
          alignment: Alignment.bottomCenter,
          image: AssetImage(WidgetAssets.backgroundT1),
          fit: BoxFit.fill,
        ),
      ),
      padding:
          const EdgeInsets.only(top: 24.0, bottom: 12.0, right: 24, left: 24.0),
      child: Column(
        children: [
          const TitleForm(
            title: '¡Bienvenido!',
            tittleColor: Colors.white,
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeDataSuccess) {
                  return HomeMenuGrid(menu: state.menu);
                }
                return const CustomLoaderProgress();
              },
            ),
          ),
        ],
      ),
    ).setScaffoldWithAppBar();
  }
}
