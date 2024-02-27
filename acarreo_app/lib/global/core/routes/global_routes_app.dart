import 'package:acarreo_app/global/modules/ticket_module/core/routes/module_routes.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';

abstract class GlobalRoutesApp {
  static String get initialRoute => '/';

  static String get authRoute => '/auth';
  static String get authLoginRoute => '$authRoute/login';

  static String get homeRoute => '/home';

  static String get ticketsRoute =>
      '$homeRoute${TicketRoutesModule.ticketsRoutes}';
  static String get listTicketsRoute =>
      '$ticketsRoute${TicketRoutesModule.listTicketRoute}';
  static String get reviewTicketRoute =>
      '$ticketsRoute${TicketRoutesModule.reviewTicketRoute}';

  static String get trackerRoute =>
      '$homeRoute${TrackerRoutesModule.trackerRoute}';
  static String get trackerFormRoute =>
      '$trackerRoute${TrackerRoutesModule.formTravelRoute}';
  static String get registerTravelRoute =>
      '$trackerFormRoute${TrackerRoutesModule.registerTravelRoute}';
  static String get previewCurrentLocationTravelRoute =>
      '$trackerFormRoute${TrackerRoutesModule.previewCurrentLocationTravelRoute}';
  static String get readTravelNFCRoute =>
      '$trackerFormRoute${TrackerRoutesModule.readTravelNFCRoute}';
  static String get detailsTicketTravelRoute =>
      '$trackerFormRoute${TrackerRoutesModule.detailsTicketTravelRoute}';
  static String get previewTicketTravelRoute =>
      '$trackerFormRoute${TrackerRoutesModule.previewTicketTravelRoute}';
}
