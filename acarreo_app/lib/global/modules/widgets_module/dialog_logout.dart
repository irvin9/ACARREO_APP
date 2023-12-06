import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/cubits/auth/auth_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/generic_dialog.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DialogLogout {
  static final _cubitAuth = Modular.get<AuthCubit>();
  static final _cubitApp = Modular.get<AcarreoCubit>();
  static show(BuildContext context, DialogMessageModel message) {
    return GenericDialog.show(
      context: context,
      child: BlocProvider.value(
        value: _cubitAuth,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return AlertDialog(
              icon:
                  const Icon(Icons.info, size: 60, color: Colors.orangeAccent),
              actions: [
                GeneralButton(
                  buttonText: 'Confirmar',
                  textColor: Colors.black87,
                  onPressed: () {
                    if (_cubitApp.pedingTickets) {
                      hide(context);
                      showCustomSnackBar(context, '¡Tiene tickets pendientes!');
                      return;
                    }
                    _cubitAuth.logout();
                  },
                  isLoading: state is AuthInitCloseSession,
                ),
                const SizedBox(height: 10.0),
                GeneralButton(
                  buttonText: 'Cancelar',
                  textColor: Colors.white,
                  buttonColor: Colors.black87,
                  onPressed:
                      state is AuthInitCloseSession ? hide(context) : () {},
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20.0, fontWeight: FontWeight.w700),
                  ).withPaddingOnly(bottom: 12),
                  Text(
                    message.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static hide(context) {
    GenericDialog.hide(context);
  }

  static void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.redAccent,
      padding: const EdgeInsets.all(25),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(25),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
