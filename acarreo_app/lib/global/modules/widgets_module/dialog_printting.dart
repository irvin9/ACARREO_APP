import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_search_printer.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/generic_dialog.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/printer/printer_cubit.dart';
import 'package:flutter/material.dart';

class DialogPritting {
  static final _printerCubit = Modular.get<PrinterCubit>();
  static final _acarreoCubit = Modular.get<AcarreoCubit>();
  static show(BuildContext context, DialogMessageModel message) {
    return GenericDialog.show(
      context: context,
      child: AlertDialog(
        icon: const Icon(Icons.print, size: 60, color: Colors.black87),
        actions: [
          GeneralButton(
            fontSize: 18.0,
            buttonText: _printerCubit.selectedPrinter != null
                ? 'Imprimir'
                : 'Seleccionar impresora',
            textColor: Colors.black87,
            onPressed: _printerCubit.selectedPrinter != null
                ? () => _printerCubit.print(_acarreoCubit.formatTicket())
                : () {
                    hide(context);
                    DialogSearchPrinter.show(context);
                  },
          ),
          const SizedBox(height: 10.0),
          GeneralButton(
            buttonText: 'No imprimir',
            textColor: Colors.white,
            buttonColor: Colors.black87,
            onPressed: () =>
                _acarreoCubit.finishForm(GlobalRoutesApp.registerTravelRoute),
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
      ),
    );
  }

  static hide(context) {
    GenericDialog.hide(context);
  }
}
