import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_loader.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

extension ScaffoldScreen on Widget {
  setMainScaffold({GlobalKey<ScaffoldState>? key}) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        key ?? GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        bottom: false,
        child: this,
      ),
    );
  }

  setScaffoldWithAppBar({GlobalKey<ScaffoldState>? key}) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        key ?? GlobalKey<ScaffoldState>();
    final acarreoCubit = Modular.get<AcarreoCubit>();

    return BlocConsumer<AcarreoCubit, AcarreoState>(
      listener: (context, state) {
        if (state is AcarreoShowLoadingModal) {
          DialogLoader.show(context, DialogMessageModel.fromMap(state.message));
        }

        if (state is AcarreoSuccess) {
          DialogLoader.hide(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const SizedBox(
              width: 140,
              child: LogoApp(assetName: WidgetAssets.logoNameLightApp),
            ),
            iconTheme: const IconThemeData(color: Colors.white, size: 32),
            actions: [
              Visibility(
                visible: acarreoCubit.pedingTickets,
                child: IconButton(
                  onPressed: () => acarreoCubit.updateTickets(),
                  icon: const Icon(color: Colors.white, Icons.cloud_upload),
                ),
              ),
              IconButton(
                onPressed: () => acarreoCubit.updateLocalData(),
                icon: const Icon(color: Colors.white, Icons.update),
              ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'about',
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.info_outline,
                              size: 24,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: SizedBox(
                              width: 10.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Sobre la app',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 10,
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.logout_outlined,
                              size: 24,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: SizedBox(
                              width: 10.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Cerrar sesión',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'logout') Modular.get<AuthCubit>().logout();
                },
              ).withPaddingSymmetric(vertical: 0),
            ],
            backgroundColor: const Color(0xFF151A20),
            actionsIconTheme: const IconThemeData(size: 32),
          ),
          body: SafeArea(
            bottom: false,
            child: this,
          ),
        );
      },
    );
  }
}
