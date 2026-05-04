flutter clean
flutter pub get
flutter build web --release -t lib/main_prod.dart
firebase deploy --only hosting:prod