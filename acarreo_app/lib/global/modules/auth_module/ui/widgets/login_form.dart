import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TittleScreen(tittleText: '¡Bienvenido!'),
          const SizedBox(
            height: 25.0,
          ),
          const GeneralTextField(
            labelText: 'Usuario',
            horizontalPadding: 16.0,
            verticalPadding: 16.0,
            icon: Icon(Icons.person),
            containerTextFieldHeight: 45.0,
            hintTextSize: 16.0,
            textInputType: TextInputType.name,
          ),
          const GeneralTextField(
            labelText: 'Contraseña',
            horizontalPadding: 16.0,
            verticalPadding: 16.0,
            icon: Icon(Icons.lock),
            containerTextFieldHeight: 45.0,
            hintTextSize: 16.0,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          GeneralButton(
            vertical: 16.0,
            horizontal: 16.0,
            // buttonColor: _darkBlue,
            buttonText: 'Iniciar sesion',
            buttonElevation: 4.0,
            textColor: Colors.black87,
            // textColor: Theme.of(context).colorScheme.onSecondary,
            // isLoading: state.isLoading,
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
