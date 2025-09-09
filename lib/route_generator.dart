import 'package:flutter/material.dart';
import 'package:untitled_sample_app/views/driver_registration_stepper_screen.dart';
import 'package:untitled_sample_app/views/login_screen.dart';
import 'package:untitled_sample_app/views/splash_screen.dart';

const String splashRoute = '/';
const String loginRoute = '/login';
const String registrationStepperRoute = '/registration-stepper';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registrationStepperRoute:
        return MaterialPageRoute(builder: (_) => const RegistrationStepperScreen());

      case '/tasting_details':
      /*return MaterialPageRoute(
            builder: (_) => const TastingDetailsScreen(),
            settings: const RouteSettings(name: '/tasting_details'));*/
      case '/wines_details':
      /*return MaterialPageRoute(
            builder: (_) => WinesDetailScreen(
                  reviewButton: args,
                ));*/

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(
          body: Center(child: Text('Something wrong in routes')),
        );
      },
    );
  }
}
