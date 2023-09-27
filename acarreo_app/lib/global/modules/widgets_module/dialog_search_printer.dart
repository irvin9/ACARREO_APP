import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/printer/printer_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/generic_dialog.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class DialogSearchPrinter {
  static final _cubit = Modular.get<PrinterCubit>();
  static show(BuildContext context) {
    _cubit.findPrinters();
    return GenericDialog.show(
      context: context,
      child: BlocBuilder<PrinterCubit, PrinterState>(
        builder: (context, state) {
          return AlertDialog(
            title: Text(
              'Buscador de impresoras',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            actions: [
              Visibility(
                visible:
                    state is! PrintersInitSearch && state is! PrintersError,
                child: GeneralButton(
                  buttonText: 'Refrescar',
                  textColor: Colors.white,
                  buttonColor: Colors.black87,
                  onPressed: state is PrintersInitSearch
                      ? null
                      : () => _cubit.findPrinters(),
                ).withPaddingSymmetric(vertical: 12.0, horizontal: 0.0),
              ),
              Visibility(
                visible:
                    state is! PrintersInitSearch && state is PrintersNotFound,
                child: GeneralButton(
                  buttonText: 'Regresar',
                  textColor: Colors.black87,
                  onPressed: () => hide(context),
                ),
              ),
              Visibility(
                visible: state is PrintersError,
                child: GeneralButton(
                  buttonText: 'Ir a configuración',
                  textColor: Colors.white,
                  buttonColor: Colors.black87,
                  onPressed: state is PrintersInitSearch
                      ? null
                      : () {
                          hide(context);
                          _cubit.printerService.goToSettingBLE();
                        },
                ),
              ),
            ],
            content: _buildBody(state),
          );
        },
      ),
    );
  }

  static _buildBody(PrinterState state) {
    if (state is PrintersFound) {
      return _buildListPrinters(state.printers);
    }

    if (state is PrintersError) {
      return _buildErrorScan();
    }

    if (state is PrintersNotFound) {
      return _buildNotFoundPrinters();
    }

    return const LoaderInnerDialog(
        description: 'Estamos buscando impresoras...');
  }

  static _buildListPrinters(List<StarXpandPrinter> printers) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: printers.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              _cubit.selectPrinter(printers[index]);
              hide(context);
            },
            leading: const Icon(Icons.print, size: 24, color: Colors.black87),
            title: Text(printers[index].model.label),
            subtitle: Text(printers[index].identifier),
          );
        },
      ),
    );
  }

  static _buildErrorScan() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.info, size: 60, color: Colors.orangeAccent),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Revise la configuración de su dispositivo.',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  static _buildNotFoundPrinters() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.print_outlined, size: 48, color: Colors.black87),
        const SizedBox(
          height: 10,
        ),
        Text(
          'No hemos encontrado impresoras cercanas.',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  static hide(context) {
    GenericDialog.hide(context);
  }
}

class LoaderInnerDialog extends StatelessWidget {
  final String description;

  const LoaderInnerDialog({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: FittedBox(
                child: CircularProgressIndicator(
                  color: Colors.black87,
                  strokeWidth: 5,
                ),
              ),
            ),
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}