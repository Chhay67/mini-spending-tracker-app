flutter clean
flutter pub get
flutter build web --release -t lib/main_dev.dart
firebase deploy --only hosting:dev