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
              seedColor: CustomColors.primaryColor,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: CustomColors.whiteColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: CustomColors.primaryColor, //<-- SEE HERE
            ),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              fillColor: CustomColors.lightGreyColor,
              filled: true,
              errorStyle: TextStyle(height: 2.h),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              focusedErrorBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              errorBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              suffixIconColor: CustomColors.greyColor,
              prefixIconColor: CustomColors.greyColor,
              focusColor: CustomColors.primaryColor,
              hintStyle: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 12.sp,
                color: CustomColors.greyColor,
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Bruno\'s Kitchen',
          navigatorObservers: [routeObserver],
          initialRoute: splashRoute,
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
