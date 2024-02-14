enum TypeRegisters { origin, destino }

abstract class TypeLocations {
  static const banco = 1;
  static const traza = 2;
  static const other = 3;
}

class FormValues {
  static const Map<String, String> optionTypeRegisters = {
    "": "Seleccione una opción",
    "0": "ORIGEN",
    "1": "DESTINO"
  };

  static const Map<String, String> optionTypeRegisterBanks = {
    "": "Seleccione una opción",
    "2": "ENTRADA DE MATERIAL",
    "3": "SALIDA DE MATERIAL",
  };

  static const Map<String, String> optionTypeLocations = {
    "": "Seleccione una opción",
    "1": "BANCO DE MATERIAL",
    "2": "TRAZA",
    "3": "OTRO"
  };

  static const Map<String, String> mappingTypeRegister = {
    "0": "origen",
    "1": "destino"
  };

  static const Map<String, String> typeRegisters = {
    "0": "Origen",
    "1": "Destino",
    "2": "Entrada de Material",
    "3": "Salida de Material",
  };
}
