import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/binds/thermal_printer_service_factory.dart';
import 'package:acarreo_app/global/core/data/enum/thermal_printer_type.dart';
import 'package:acarreo_app/global/core/domain/models/thermal_printer_device.dart';
import 'package:acarreo_app/global/core/domain/service/thermal_printer_service.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  final List<ThermalPrinterDevice> _printers = [];
  ThermalPrinterDevice? _selectedPrinter;

  int _totalPageCopies = 1;

  int _currentPagePrint = 0;

  int get currentPrint => _currentPagePrint;

  int get totalCopies => _totalPageCopies;

  late ThermalPrinterService _printerService;

  set setTotalCopies(int total) => _totalPageCopies = total;

  List<ThermalPrinterDevice> get printers => _printers;
  ThermalPrinterDevice? get selectedPrinter => _selectedPrinter;

  PrinterCubit() : super(const PrinterInitial());

  Future<void> init() async {
    emit(const PrinterInitial());
  }

  Future<void> initPrinterService(ThermalPrinterType printerType) async {
    final printerService =
        ThermalPrinterServiceFactory.createService(printerType);
    _printerService = printerService;
    emit(const PrinterServiceWaiting());
  }

  Future<void> findPrinters() async {
    Future.delayed(Duration.zero);
    emit(const PrintersInitSearch());
    _printers.clear();
    final newPrinters = await _printerService.getPrinters();
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
    _currentPagePrint = 0;
    if (selectedPrinter == null) return;
    emit(const PrinterInitPrint());
    while (currentPrint < totalCopies) {
      final printer = selectedPrinter!;
      final status = await _printerService.print(printer, data);
      if (!status) break;
      _currentPagePrint++;
    }
    await _printerService.disconnect();
    if (currentPrint == totalCopies) {
      emit(const PrinterSuccessPrint());
    } else {
      emit(const PrinterErrorPrint());
    }
    setTotalCopies = 1;
    return;
  }

  void selectPrinter(ThermalPrinterDevice printer) {
    _selectedPrinter = printer;
  }
}
