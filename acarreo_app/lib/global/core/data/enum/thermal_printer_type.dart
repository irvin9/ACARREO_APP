enum ThermalPrinterType { starxpand, zebra }

extension ThermalPrinterTypeExtension on ThermalPrinterType {
  String toTitle() {
    if (this == ThermalPrinterType.starxpand) {
      return 'Impresoras ${ThermalPrinterType.starxpand.name.toUpperCase()}';
    }

    if (this == ThermalPrinterType.zebra) {
      return 'Impresoras ${ThermalPrinterType.zebra.name.toUpperCase()}';
    }

    return 'Impresora desconocida';
  }
}
