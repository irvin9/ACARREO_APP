import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuData> menu = [
      MenuData(Icons.move_to_inbox_outlined, 'Registrar Acarreos',
          GlobalRoutesApp.registerTravelRoute),
      MenuData(Icons.find_in_page_outlined, 'Registrar Bancos',
          GlobalRoutesApp.registerTravelRoute)
    ];
    Modular.get<AcarreoCubit>().getLocalData();
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
            child: GridView.builder(
              itemCount: menu.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) => Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: InkWell(
                  onTap: () => Modular.to.pushNamed(menu[index].uri),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        menu[index].icon,
                        size: 36,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        menu[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87),
                      )
                    ],
                  ).withPaddingSymmetric(),
                ),
              ),
            ),
          ),
        ],
      ),
    ).setScaffoldWithAppBar();
  }
}
