abstract class TrackerRoutesModule {
  static String get ticketsRoutes => '/tickets';
  static String get listTicketRoute => '/list-tickets';
  static String get reviewTicketRoute => '/review-ticket';

  static String get formTravelRoute => '/form';
  static String get registerTravelRoute => '/register-travel';
  static String get previewCurrentLocationTravelRoute =>
      '/preview-current-location-travel';
  static String get readTravelNFCRoute => '/read-travel-nfc';
  static String get detailsTicketTravelRoute => '/details-ticket-travel';
  static String get previewTicketTravelRoute => '/preview-ticket-travel';
}
