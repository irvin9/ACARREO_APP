import 'package:acarreo_app/global/core/acarreo_core_module.dart';
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

  setScaffoldWithAppBar(
      {GlobalKey<ScaffoldState>? key, bool disableToBack = false}) {
    final GlobalKey<ScaffoldState> scaffoldKey =
        key ?? GlobalKey<ScaffoldState>();
    final acarreoCubit = Modular.get<AcarreoCubit>();

    return BlocConsumer<AcarreoCubit, AcarreoState>(
      listener: (context, state) {
        if (state is AcarreoShowLoadingModal) {
          DialogLoader.show(context, DialogMessageModel.fromMap(state.message));
        }

        if (state is AcarreoError) {
          DialogLoader.hide(context);
          DialogError.show(context, DialogMessageModel.fromMap(state.message),
              () => DialogError.hide(context));
        }

        if (state is AcarreoSuccess) {
          DialogLoader.hide(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const SizedBox(
              width: 90,
              height: 40,
              child: LogoApp(assetName: WidgetAssets.logoNameLightApp),
            ),
            automaticallyImplyLeading: !disableToBack,
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
                    value: 'printers',
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.print_outlined,
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
                            text: 'Impresoras',
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
                    value: 'list-tickets',
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.article_outlined,
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
                            text: 'Ver tickets',
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
                  if (value == 'logout') {
                    DialogLogout.show(
                      context,
                      DialogMessageModel.fromMap(
                        {
                          'title': '¿Desea salir de su sesión?',
                          'description':
                              'Al salir los datos actuales se perderán.'
                        },
                      ),
                    );
                  }
                  if (value == 'printers') {
                    DialogSearchPrinter.show(context);
                  }

                  if (value == 'list-tickets') {
                    Modular.to.pushNamed(GlobalRoutesApp.listTicketsRoute);
                  }
                },
              ).withPaddingSymmetric(vertical: 0),
            ],
            backgroundColor: const Color(0xFF384596),
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
