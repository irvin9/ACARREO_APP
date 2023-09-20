enum TypeLocations { origin, destino }

class FormValues {
  static const Map<String, String> optionTypeTravels = {
    "": "Seleccione una opción",
    "origen": "ORIGEN",
    "destino": "DESTINO"
  };

  static const Map<String, String> optionTravels = {
    "": "Seleccione una opción",
    "origen": "TRAZA",
    "destino": "BANCO DE MATERIAL",
    "otro": "OTRO"
  };

  static const Map<String, String> mappingTypeLocation = {
    "1": "origen",
    "2": "destino"
  };
}
