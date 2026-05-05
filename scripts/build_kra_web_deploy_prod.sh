flutter clean
flutter pub get
flutter build web --release -t lib/main_kra_prod.dart
firebase deploy --only hosting:kra
