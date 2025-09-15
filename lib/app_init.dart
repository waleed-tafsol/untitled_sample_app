import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled_sample_app/route_generator.dart';
import 'package:untitled_sample_app/utils/custom_colors.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class AppInit extends StatelessWidget {
  const AppInit({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      //useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: CustomColors.purpleColor,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: CustomColors.whiteColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: CustomColors.purpleColor, //<-- SEE HERE
            ),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              fillColor: CustomColors.lightGreyColor,
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              suffixIconColor: CustomColors.greyColor,
              prefixIconColor: CustomColors.greyColor,
              focusColor: CustomColors.purpleColor,
              hintStyle: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                color: CustomColors.greyColor,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.purpleColor),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Bruno\'s Kitchen',
          navigatorObservers: [routeObserver],
          initialRoute: homeRoute,
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
