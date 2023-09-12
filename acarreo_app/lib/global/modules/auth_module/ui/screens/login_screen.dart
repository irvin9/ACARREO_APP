import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = Modular.get<AuthCubit>();
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF1E293B),
          // color: Colors.blueGrey,
          image: DecorationImage(
            isAntiAlias: true,
            alignment: Alignment.bottomCenter,
            image: AssetImage(WidgetAssets.backgroundT1),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(
                flex: 5,
                child: LoginForm(cubit: authCubit),
              ),
              const LogoApp(
                assetName: WidgetAssets.logoNameApp,
                width: 164.0,
                height: 64.0,
              ),
            ],
          ),
        ),
      ),
    ).setMainScaffold();
  }
}
