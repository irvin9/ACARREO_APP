abstract class GlobalRoutesApp {
  static String get initialRoute => '/';
  static String get authRoute => '/auth';
  static String get authLoginRoute => '$authRoute/login';

  static String get homeRoute => '/home';
  static String get trackerRoute => '$homeRoute/tracker';
  static String get registerTravelRoute => '$trackerRoute/register-travel';
  static String get readTravelNFCRoute => '$trackerRoute/read-travel-nfc';
}
