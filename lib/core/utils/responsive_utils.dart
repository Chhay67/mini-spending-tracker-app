import 'package:flutter/material.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < mobileMaxWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletMaxWidth;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }
}
