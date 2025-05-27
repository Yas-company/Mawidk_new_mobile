import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight;
    // 812 is the layout height that designer uses (example: iPhone X)
    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth;
    // 375 is the layout width that designer uses (example: iPhone X)
    return (inputWidth / 375.0) * screenWidth;
  }

  static double containerHeight(double input) {// 300
    return getProportionateScreenHeight(input);
  }

  static double containerWidth(double input) {// 200
    return getProportionateScreenWidth(input);
  }


  void init(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    isMobilePortrait = isPortrait && screenWidth < 450;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
  }
}
