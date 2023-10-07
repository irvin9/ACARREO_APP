import 'package:acarreo_app/global/core/acarreo_core_module.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  final StartxpandPrinterBluetoothService printerService;
  final List<StarXpandPrinter> _printers = [];
  StarXpandPrinter? _selectedPrinter;

  int _totalPageCopies = 1;

  int _currentPagePrint = 0;

  int get currentPrint => _currentPagePrint;

  int get totalCopies => _totalPageCopies;

  set setTotalCopies(int total) => _totalPageCopies = total;

  List<StarXpandPrinter> get printers => _printers;
  StarXpandPrinter? get selectedPrinter => _selectedPrinter;

  PrinterCubit(this.printerService) : super(const PrinterInitial());

  Future<void> initPrinter() async {
    emit(const PrinterInitial());
  }

  Future<void> findPrinters() async {
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

  Future<void> print(Map<String, dynamic> data) async {
    if (selectedPrinter == null) return;
    emit(const PrinterInitPrint());
    while (currentPrint < totalCopies) {
      final status = await printerService.print(selectedPrinter!, data);
      if (!status) break;
      _currentPagePrint++;
    }
    if (currentPrint == totalCopies) {
      emit(const PrinterSuccessPrint());
      _currentPagePrint = 0;
      return;
    }
    emit(const PrinterErrorPrint());
    return;
  }

  void selectPrinter(StarXpandPrinter printer) {
    _selectedPrinter = printer;
  }
}
