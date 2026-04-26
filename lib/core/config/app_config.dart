

import '../enum/flavor.dart';



class AppConfig {
  AppConfig._();

  static Flavor appFlavor = Flavor.dev;

  static void init({required Flavor flavor}) {
    appFlavor = flavor;
  }

  static bool get isProduction => appFlavor == Flavor.production;

  static String get appName {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Spend Tracker Dev';
      case Flavor.staging:
        return 'Spend Tracker Staging';
      case Flavor.production:
        return 'Spend Tracker';
    }
  }

// static FirebaseOptions get firebaseOptions {
//   switch (appFlavor) {
//     case Flavor.dev:
//       return dev.DefaultFirebaseOptions.currentPlatform;
//     case Flavor.staging:
//       return dev.DefaultFirebaseOptions.currentPlatform;
//     case Flavor.production:
//       return prod.DefaultFirebaseOptions.currentPlatform;
//     default:
//       return dev.DefaultFirebaseOptions.currentPlatform;
//   }
// }
}