import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_colors.dart';
import 'package:untitled_sample_app/view_models/auth_view_model.dart';
import 'package:untitled_sample_app/view_models/driver_stepper_view_model.dart';
import 'package:untitled_sample_app/view_models/driver_personal_info_view_model.dart';
import 'package:untitled_sample_app/view_models/driver_documents_view_model.dart';
import 'package:untitled_sample_app/view_models/driver_vehicle_view_model.dart';
import 'package:untitled_sample_app/view_models/driver_shift_view_model.dart';
import 'package:untitled_sample_app/view_models/otp_view_model.dart';

import 'app_init.dart';
import 'firebase_options.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = CustomColors.primaryColor
    ..backgroundColor = CustomColors.whiteColor
    ..indicatorColor = CustomColors.primaryColor
    ..textColor = CustomColors.primaryColor
    ..maskColor = Colors.black.withValues(alpha: 0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configLoading();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => OtpViewModel()),

      ],
      child: AppInit(),
    ),
  );
}
