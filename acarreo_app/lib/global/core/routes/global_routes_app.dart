abstract class GlobalRoutesApp {
  static String get initialRoute => '/';
  static String get authRoute => '/auth';
  static String get authLoginRoute => '$authRoute/login';

  // static String get homeRoute => '/home';
  static String get trackerRoute => '/tracker';

  static String get ticketsRoute => '$trackerRoute/tickets';
  static String get listTicketsRoute => '$ticketsRoute/list-tickets';
  static String get reviewTicketRoute => '$ticketsRoute/review-ticket';

  static String get trackerFormRoute => '$trackerRoute/form';
  static String get registerTravelRoute => '$trackerFormRoute/register-travel';
  static String get previewCurrentLocationTravelRoute =>
      '$trackerFormRoute/preview-current-location-travel';
  static String get readTravelNFCRoute => '$trackerFormRoute/read-travel-nfc';
  static String get detailsTicketTravelRoute =>
      '$trackerFormRoute/details-ticket-travel';
  static String get previewTicketTravelRoute =>
      '$trackerFormRoute/preview-ticket-travel';
}
