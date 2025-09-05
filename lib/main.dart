import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/route_generator.dart';
import 'package:untitled_sample_app/utils/custom_colors.dart';
import 'package:untitled_sample_app/view_models/auth_view_model.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = CustomColors.orangeColor
    ..backgroundColor = CustomColors.whiteColor
    ..indicatorColor = CustomColors.orangeColor
    ..textColor = CustomColors.orangeColor
    ..maskColor = Colors.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() {
  configLoading();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: CustomColors.orangeColor, //<-- SEE HERE
            ),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              fillColor: CustomColors.lightGreyColor,
              filled: true,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              suffixIconColor: CustomColors.greyColor,
              prefixIconColor: CustomColors.greyColor,
              focusColor: CustomColors.orangeColor,
              hintStyle: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                color: CustomColors.greyColor,
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.orangeColor),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Bruno\'s Kitchen',
          navigatorObservers: [routeObserver],
          initialRoute: '/login',
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
