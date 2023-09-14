import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/user_credential.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/auth_module/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
            onChanged: (value) => cubit.credentials.addAll({'user': value}),
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
            listener: (context, state) {
              if (state is AuthSuccess) {
                Modular.to.pushNamed(
                  GlobalRoutesApp.registerTravelRoute,
                );
              }
            },
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

class SuccessDialog extends StatelessWidget {
  final UserModel userModel;
  const SuccessDialog({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Bienvenido a tu cuenta ${userModel.name.toUpperCase()}'),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 32),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Has Iniciado Session Exitosamente",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            Column(
              children: [
                Text(
                  'Tienes asignado el cliente: ${userModel.idClient}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Tienes asignado la obra: ${userModel.idProject}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
