import 'package:acarreo_app/global/core/domain/models/user_credential.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  final AuthCubit cubit;
  const LoginForm({super.key, required this.cubit});

  String? validation(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TittleScreen(tittleText: '¡Bienvenido!'),
          const SizedBox(
            height: 25.0,
          ),
          GeneralTextField(
            labelText: 'Usuario',
            horizontalPadding: 16.0,
            verticalPadding: 16.0,
            icon: const Icon(Icons.person),
            containerTextFieldHeight: 45.0,
            hintTextSize: 16.0,
            textInputType: TextInputType.name,
            onChanged: (value) => cubit.credentials.addAll({'username': value}),
            validator: (value) => validation(value),
          ),
          GeneralTextField(
            labelText: 'Contraseña',
            horizontalPadding: 16.0,
            verticalPadding: 16.0,
            icon: const Icon(Icons.lock),
            containerTextFieldHeight: 45.0,
            hintTextSize: 16.0,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            onChanged: (value) => cubit.credentials.addAll({'password': value}),
            validator: (value) => validation(value),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              bool isLoading = cubit.isLoading;
              return GeneralButton(
                vertical: 16.0,
                horizontal: 16.0,
                buttonText: 'Iniciar sesion',
                buttonElevation: 4.0,
                textColor: Colors.black87,
                isLoading: isLoading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final UserCredential credentials =
                        UserCredential.fromMap(cubit.credentials);
                    cubit.login(credentials);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
