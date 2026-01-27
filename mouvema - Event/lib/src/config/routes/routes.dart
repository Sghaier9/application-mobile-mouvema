import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../injector.dart';
import '../../presentation/forgot_password/pages/forgot_password_screen.dart';
import '../../presentation/login/pages/login_screen.dart';
import '../../presentation/login/pages/login_with_password.dart';
import '../../presentation/main/fill_profil/pages/fill_profile_screen.dart';
import '../../presentation/main/event_details/event_details_screen.dart';
import '../../presentation/main/main_screen.dart';
import '../../presentation/main/post_event/pages/post_event_screen.dart';
import '../../presentation/main/profile/pages/profile_screen.dart';
import '../../presentation/register/pages/register_screen.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String loginWithPassword = "/loginWithPassword";
  static const String register = "/register";
  static const String forgotPassword = "/forgortPassword";

  static const String main = "/main";
  static const String loadDetails = "/loadDetails";
  static const String postLoad = "/postLoad";
  static const String fillProfil = "/fillProfil";
  static const String profil = "/Profil";
  static const String mapScreen = "/mapScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // login screen
      case Routes.login:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const LoginScreen();
        });
      // login With password
      case Routes.loginWithPassword:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const LoginWithPassword();
        });
      // main screen
      case Routes.main:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          homeInstances();
          return const MainScreen();
        });
      // forgot password
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const ForgotPasswordScreen();
        });

      // **************************
      case Routes.fillProfil:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const FillProfileScreen();
        });
      case Routes.profil:
        // profilInstances();
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const ProfileScreen();
        });

      //************************* */

      case Routes.register:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return const RegisterScreen();
        });

      //************************** */

      case Routes.loadDetails:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          final Event arg = settings.arguments as Event;
          return LoadDetailsScreen(event: arg);
        });

      //************************** */

      //************************** */
      case Routes.postLoad:
        return MaterialPageRoute(builder: (BuildContext ctx) {
          return PostLoadScreen();
        });
      default:
        // naamlou page 404
        return MaterialPageRoute(builder: (ctx) {
          return const Placeholder(
            child: Text('404 Not Found'),
          );
        });
    }
  }
}
