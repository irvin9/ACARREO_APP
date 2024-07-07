part of 'printer_cubit.dart';

abstract class PrinterState extends Equatable {
  const PrinterState();
}

class PrinterInitial extends PrinterState {
  const PrinterInitial();
  @override
  List<Object?> get props => [];
}

class PrintersInitSearch extends PrinterState {
  const PrintersInitSearch();

  @override
  List<Object?> get props => [];
}

class PrintersFound extends PrinterState {
  final List<ThermalPrinterDevice> printers;
  const PrintersFound(this.printers);

  @override
  List<Object?> get props => [printers];
}

class PrintersNotFound extends PrinterState {
  const PrintersNotFound();

  @override
  List<Object?> get props => [];
}

class PrintersError extends PrinterState {
  const PrintersError();

  @override
  List<Object?> get props => [];
}

class PrinterInitPrint extends PrinterState {
  const PrinterInitPrint();

  @override
  List<Object?> get props => [];
}

class PrinterSuccessPrint extends PrinterState {
  const PrinterSuccessPrint();

  @override
  List<Object?> get props => [];
}

class PrinterErrorPrint extends PrinterState {
  const PrinterErrorPrint();

  @override
  List<Object?> get props => [];
}
