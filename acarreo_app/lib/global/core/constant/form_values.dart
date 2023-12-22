enum TypeRegisters { origin, destino }

abstract class TypeLocations {
  static const banco = 1;
  static const traza = 2;
  static const other = 3;
}

class FormValues {
  static const Map<String, String> optionTypeRegisters = {
    "": "Seleccione una opción",
    "origen": "ORIGEN",
    "destino": "DESTINO"
  };

  static const Map<String, String> optionTypeRegisterBanks = {
    "": "Seleccione una opción",
    "destino": "ENTRADA DE MATERIAL",
    "origen": "SALIDA DE MATERIAL",
  };

  static const Map<String, String> optionTypeLocations = {
    "": "Seleccione una opción",
    "1": "BANCO DE MATERIAL",
    "2": "TRAZA",
    "3": "OTRO"
  };

  static const Map<String, String> mappingTypeRegister = {
    "1": "origen",
    "2": "destino"
  };
}
