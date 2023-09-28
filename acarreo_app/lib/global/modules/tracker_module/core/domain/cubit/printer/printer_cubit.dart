import 'package:acarreo_app/global/core/acarreo_core_module.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  final StartxpandPrinterBluetoothService printerService;
  final List<StarXpandPrinter> _printers = [];
  StarXpandPrinter? _selectedPrinter;

  List<StarXpandPrinter> get printers => _printers;
  StarXpandPrinter? get selectedPrinter => _selectedPrinter;

  PrinterCubit(this.printerService) : super(const PrinterInitial());

  findPrinters() async {
    Future.delayed(Duration.zero);
    emit(const PrintersInitSearch());
    _printers.clear();
    final newPrinters = await printerService.getPrinters();
    if (newPrinters == null) {
      emit(const PrintersError());
      return;
    }
    if (newPrinters.isEmpty) {
      emit(const PrintersNotFound());
      return;
    }
    _printers.addAll(newPrinters);
    emit(PrintersFound(newPrinters));
  }

  Future<bool> print(Map<String, dynamic> data) async {
    if (selectedPrinter == null) return false;
    final status = await printerService.print(selectedPrinter!, data);
    return status;
  }

  void selectPrinter(StarXpandPrinter printer) {
    _selectedPrinter = printer;
  }
}
