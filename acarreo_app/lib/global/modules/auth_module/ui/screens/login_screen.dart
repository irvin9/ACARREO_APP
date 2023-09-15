import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = Modular.get<AuthCubit>();
    return SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF151A20),
          image: DecorationImage(
            isAntiAlias: true,
            alignment: Alignment.bottomCenter,
            image: AssetImage(WidgetAssets.backgroundT1),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: LoginForm(cubit: authCubit),
          ),
        ),
      ),
    ).setMainScaffold();
  }
}
