import 'package:flutter/material.dart';

abstract class TextStyles {
  static TextStyle styleRegular16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context: context, fontSize: 16),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      // color: Theme.of(context).colorScheme.onBackground,
      fontSize: getResponsiveFontSize(context: context, fontSize: 16),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium16(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFF064061),
      fontSize: getResponsiveFontSize(context: context, fontSize: 16),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium20(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context: context, fontSize: 20),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleSemiBold16(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFF064061),
      fontSize: getResponsiveFontSize(context: context, fontSize: 16),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold20(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFF064061),
      fontSize: getResponsiveFontSize(context: context, fontSize: 20),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFFAAAAAA),
      fontSize: getResponsiveFontSize(context: context, fontSize: 12),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold24(BuildContext context) {
    return TextStyle(
      // color: Theme.of(context).colorScheme.onSurface,
      fontSize: getResponsiveFontSize(context: context, fontSize: 24),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFFAAAAAA),
      fontSize: getResponsiveFontSize(context: context, fontSize: 14),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold18(BuildContext context) {
    return TextStyle(
      // color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context: context, fontSize: 18),
      fontFamily: 'playfair',
      fontWeight: FontWeight.w600,
    );
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize({
  required BuildContext context,
  required double fontSize,
}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;

  static late double width, height;

  static init(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
  }
}
