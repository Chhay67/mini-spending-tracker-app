
import 'package:flutter/cupertino.dart';

class AppPadding {

  AppPadding._();

  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;


  static EdgeInsets get horizontal => const EdgeInsets.symmetric(horizontal: defaultPadding);
  static EdgeInsets get vertical => const EdgeInsets.symmetric(vertical: defaultPadding);
  static EdgeInsets get all => const EdgeInsets.all(defaultPadding);

}