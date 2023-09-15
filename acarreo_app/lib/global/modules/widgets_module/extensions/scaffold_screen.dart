import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

extension ScaffoldScreen on Widget {
  setMainScaffold({GlobalKey<ScaffoldState>? key}) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: this,
      ),
    );
  }

  setScaffoldWithAppBar({GlobalKey<ScaffoldState>? key}) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const SizedBox(
          width: 140,
          child: LogoApp(assetName: WidgetAssets.logoNameLightApp),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(color: Colors.white, Icons.cloud_upload),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(color: Colors.white, Icons.update),
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
              // Handle menu item selection
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
  }
}
