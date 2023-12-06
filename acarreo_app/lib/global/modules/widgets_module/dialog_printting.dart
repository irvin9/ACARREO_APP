import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DialogPritting {
  static final _printerCubit = Modular.get<PrinterCubit>();
  static final _acarreoCubit = Modular.get<AcarreoCubit>();
  static show({
    required BuildContext context,
    required DialogMessageModel message,
    required Map<String, dynamic> data,
    void Function()? onBack,
  }) {
    _printerCubit.initPrinter();
    return GenericDialog.show(
      context: context,
      child: BlocBuilder<PrinterCubit, PrinterState>(
        bloc: _printerCubit..initPrinter(),
        builder: (context, state) {
          return _buildBody(context, state, message, data, onBack);
        },
      ),
    );
  }

  static _buildBody(
    BuildContext context,
    PrinterState state,
    DialogMessageModel message,
    Map<String, dynamic> data,
    void Function()? onBack,
  ) {
    switch (state) {
      case PrinterErrorPrint():
        return _buildErrorBody(data);
      case PrinterSuccessPrint():
        return _buildSuccessBody();
      case PrinterInitPrint():
        return _buildLoaderBody();
      default:
        return _buildInitBody(context, message, data, onBack);
    }
  }

  static _buildErrorBody(Map<String, dynamic> data) {
    return AlertDialog(
      icon:
          const Icon(Icons.error_outline_outlined, size: 60, color: Colors.red),
      actions: [
        GeneralButton(
          buttonText: 'Reintentar',
          textColor: Colors.white,
          buttonColor: Colors.black87,
          onPressed: () => _printerCubit.print(data),
        ),
        const SizedBox(height: 10.0),
        GeneralButton(
          buttonText: 'Cerrar',
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
            'Ha ocurrido algo con la impresión, vuelva intentarlo más tarde.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  static _buildSuccessBody() {
    return AlertDialog(
      icon:
          const Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
      actions: [
        GeneralButton(
          buttonText: 'Finalizar',
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
            'Se ha compleado la impresión de forma exitosa.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  static _buildLoaderBody() {
    return AlertDialog(
      title: Text(
        'Imprimiendo ticket',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
      content: const LoaderInnerDialog(
          description: 'Estamos imprimiendo su ticket...'),
    );
  }

  static _buildInitBody(BuildContext context, DialogMessageModel message,
      Map<String, dynamic> data, void Function()? onBack) {
    return AlertDialog(
      icon: const Icon(Icons.print, size: 60, color: Colors.black87),
      actions: [
        Visibility(
          visible: _printerCubit.selectedPrinter != null,
          child: CounterButton(
              onPressed: (value) => _printerCubit.setTotalCopies = value),
        ),
        const SizedBox(height: 10.0),
        GeneralButton(
          fontSize: 18.0,
          buttonText: _printerCubit.selectedPrinter != null
              ? 'Imprimir'
              : 'Seleccionar impresora',
          textColor: Colors.black87,
          onPressed: _printerCubit.selectedPrinter != null
              ? () => _printerCubit.print(data)
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
          onPressed: onBack ?? () => hide(context),
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
  }

  static void hide(context) {
    GenericDialog.hide(context);
  }
}
