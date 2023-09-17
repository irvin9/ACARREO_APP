abstract class GlobalRoutesApp {
  static String get initialRoute => '/';
  static String get authRoute => '/auth';
  static String get authLoginRoute => '$authRoute/login';

  static String get homeRoute => '/home';
  static String get trackerRoute => '$homeRoute/tracker';
  static String get trackerFormRoute => '$trackerRoute/form';
  static String get registerTravelRoute => '$trackerFormRoute/register-travel';
  static String get readTravelNFCRoute => '$trackerFormRoute/read-travel-nfc';
  static String get detailsTicketTravelRoute =>
      '$trackerFormRoute/details-ticket-travel';
  static String get previewTicketTravelRoute =>
      '$trackerFormRoute/preview-ticket-travel';
}
