
import 'package:flutter/widgets.dart';

class CustomColors {
  static const Color orangeColor = Color.fromRGBO(215, 136, 9, 1);
  static Color orangeColorTint = const Color.fromRGBO(215, 136, 9, 0.3);

  static const Color brownColor = Color.fromRGBO(106, 51, 12, 1);
  static Color lightBrownColor = const Color.fromRGBO(203, 150, 112, 1);
  static Color greenColor = const Color.fromRGBO(46, 213, 115, 1);

  static const Color blackColor = Color.fromRGBO(10, 11, 14, 1);
  static Color lightBlackColor = const Color.fromRGBO(67, 69, 75, 1);

  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color whiteColorShade = Color.fromRGBO(242, 247, 249, 0.5);
  static const Color whiteColorTint = Color.fromRGBO(255, 255, 255, 0.5);

  static const Color greyColor = Color.fromRGBO(133, 136, 141, 1);
  static const Color greyShadeColor = Color.fromRGBO(135, 135, 135, 1);
  static const Color greyMediumColor = Color.fromRGBO(245, 242, 251, 1);
  static const Color greyMediumLightColor = Color.fromRGBO(239, 239, 239, 1);
  static const Color lightGreyColor = Color.fromRGBO(248, 248, 249, 1);

  static const Color yellowColor = Color.fromRGBO(255, 202, 0, 1);
  static const Color purpleColor = Color.fromRGBO(123, 76, 223, 1);
  static const Color purpleColorTint = Color.fromRGBO(123, 76, 223, 0.5);


  static const Color color5 = Color.fromRGBO(255, 184, 100, 1);
  static Color tintColor3 = const Color.fromRGBO(167, 175, 186, 0.5);
  static const Color color6 = Color.fromRGBO(118, 131, 159, 1);

  static Gradient gradientColor1 = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromRGBO(137, 171, 227, 0.0),
        Color.fromRGBO(137, 171, 227, 1),
      ]);

  static LinearGradient linearGradient1 = const LinearGradient(
      colors: <Color>[
        Color.fromRGBO(248, 248, 249, 1),
        Color.fromRGBO(123, 76, 223, 0.3),
        Color.fromRGBO(255, 202, 0, 0.3),
        Color.fromRGBO(248, 248, 249, 1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.25, 0.4, 0.6, 8]);

  static LinearGradient linearGradient2 = const LinearGradient(
      colors: <Color>[
        Color.fromRGBO(215, 136, 9, 0.1),
        Color.fromRGBO(123, 76, 223, 0.1),
     //   Color.fromRGBO(255, 202, 0, 0.3),
      //  Color.fromRGBO(248, 248, 249, 1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
     // stops: [0.25, 0.4, 0.6, 8],
  );

}
