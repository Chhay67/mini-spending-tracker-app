

import '../enum/flavor.dart';



class AppConfig {
  AppConfig._({
    required this.flavor,
  });

  final FlavorEnum flavor;

  static late AppConfig instance;

  static void init({required FlavorEnum flavor}) {
    instance = AppConfig._(flavor: flavor);
  }

  static FlavorEnum get appFlavor => instance.flavor;

  // static bool get isProduction => appFlavor == FlavorEnum.production;

  static String get appName {
    switch (appFlavor) {
      case FlavorEnum.dev:
        return 'Spend Tracker Dev';
      case FlavorEnum.staging:
        return 'Spend Tracker Staging';
      case FlavorEnum.production:
        return 'Spend Tracker';
    }
  }

// static FirebaseOptions get firebaseOptions {
//   switch (appFlavor) {
//     case FlavorEnum.dev:
//       return dev.DefaultFirebaseOptions.currentPlatform;
//     case FlavorEnum.staging:
//       return dev.DefaultFirebaseOptions.currentPlatform;
//     case FlavorEnum.production:
//       return prod.DefaultFirebaseOptions.currentPlatform;
//   }
// }
}