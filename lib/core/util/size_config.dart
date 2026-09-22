// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
//
// class SizeConfig {
//
//   static double get screenWidth => _screenWidth;
//   static double get screenHeight => _screenHeight;
//
//   static double _screenWidth;
//   static double _screenHeight;
//   static double _blockWidth = 0;
//   static double _blockHeight = 0;
//
//   static double textMultiplier;
//   static double imageSizeMultiplier;
//   static double heightMultiplier;
//   static double widthMultiplier;
//   static bool isPortrait = true;
//   static bool isMobilePortrait = false;
//
//   static bool isMobile = true;
//
//   static void initApp(Size size) {
//     if (size.width > 600) {
//       isMobile = false;
//     } else {
//       isMobile = true;
//     }
//     _screenWidth = size.width;
//     _screenHeight = size.height;
//   }
//
//   // static void init(BoxConstraints constraints, Orientation orientation) {
//   //   // final mediaQueryData = MediaQuery.of(context);
//   //   // mediaQueryData.orientation == Orientation.landscape
//   //   print(constraints);
//   //   print(orientation);
//   //   if (orientation == Orientation.portrait) {
//   //     _screenWidth = constraints.maxWidth;
//   //     _screenHeight = constraints.maxHeight;
//   //     isPortrait = true;
//   //     if (_screenWidth < 450) {
//   //       isMobilePortrait = true;
//   //     }
//   //   } else {
//   //     _screenWidth = constraints.maxHeight;
//   //     _screenHeight = constraints.maxWidth;
//   //     isPortrait = false;
//   //     isMobilePortrait = false;
//   //   }
//   //
//   //   // _blockWidth = _screenWidth / 100;
//   //   // _blockHeight = _screenHeight / 100;
//   //
//   //   textMultiplier = _blockHeight;
//   //   imageSizeMultiplier = _blockWidth;
//   //   heightMultiplier = _blockHeight;
//   //   widthMultiplier = _blockWidth;
//   //
//   //   print(_screenWidth);
//   // }
// }