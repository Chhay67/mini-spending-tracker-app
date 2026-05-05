
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import '../enum/flavor.dart';
import '../../firebase_options/firebase_options_dev.dart' as dev;
import '../../firebase_options/firebase_options_prod.dart' as prod;
import '../../firebase_options/firebase_options_kra.dart' as kra;



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

  static String get appName {
    switch (appFlavor) {
      case FlavorEnum.dev:
        return 'Spend Tracker Dev';
      case FlavorEnum.staging:
        return 'Spend Tracker Staging';
      case FlavorEnum.production:
        return 'Spend Tracker';
      case FlavorEnum.kra:
        return "Spend Tracker";
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case FlavorEnum.dev:
        return 'https://script.google.com/macros/s/AKfycbwZ9QZ6ZosPyYg2Sl68ggjxs7pgPCOdUj7E-skgC1nSzDZ2v2uWNiGD2P-KWE8WAlDXQw/exec';
      case FlavorEnum.staging:
        return 'https://script.google.com/macros/s/AKfycbwZ9QZ6ZosPyYg2Sl68ggjxs7pgPCOdUj7E-skgC1nSzDZ2v2uWNiGD2P-KWE8WAlDXQw/exec';
      case FlavorEnum.production:
        return 'https://script.google.com/macros/s/AKfycbwO6DHsXaZU9DgkKU4YTpPQ-oZpGHJ5-2FBMdamhO-I0BG2qGB6q9OsglMqF_v5cPhl/exec';
      case  FlavorEnum.kra:
        return "https://script.google.com/macros/s/AKfycby-v9Z5WPLTrRLli12BnPlq1hZa_Ciybd0s_hmd3-jbDVI27RnC_NxcKL1JApKd5ZY2-g/exec";
    }
  }

static FirebaseOptions get firebaseOptions {
  switch (appFlavor) {
    case FlavorEnum.dev:
      return dev.DefaultFirebaseOptions.currentPlatform;
    case FlavorEnum.staging:
      return dev.DefaultFirebaseOptions.currentPlatform;
    case FlavorEnum.production:
      return prod.DefaultFirebaseOptions.currentPlatform;
    case FlavorEnum.kra:
      return kra.DefaultFirebaseOptions.currentPlatform;
  }
}
}