import 'package:bank/screens/auth/login/login_screen.dart';
import 'package:bank/screens/auth/register/register_screen.dart';
import 'package:bank/screens/no_internet/no_internet_screen.dart';
import 'package:bank/screens/on_boarding/on_boarding_screen.dart';
import 'package:bank/screens/payment/payment_screen.dart';
import 'package:bank/screens/splash/splash_screen.dart';
import 'package:bank/screens/tab/tab_screen.dart';
import 'package:bank/screens/transfer/transfer_screen.dart';
import 'package:bank/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../first_method/confirm_pin_screen.dart';
import '../first_method/entry_pin_screen.dart';
import '../first_method/second_method/biometric_screen.dart';
import '../first_method/set_pin_screen.dart';
import 'edit_profile/edit_profile.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.noInternetRoute:
        return navigate(NoInternetScreen(
            onInternetComeBack: settings.arguments as VoidCallback));

      case RouteNames.transferRoute:
        return navigate(const TransferScreen());
      case RouteNames.paymentRoute:
        return navigate(const PaymentScreen());
      case RouteNames.editProfileRoute:
        return navigate(
          EditProfileScreen(
            voidCallback: settings.arguments as VoidCallback,
          ),
        );
      case RouteNames.authRoute:
        return navigate(
          LoginScreen(
            currentEmail: settings.arguments as String? ?? "",
          ),
        );

      case RouteNames.setPinRoute:
        return navigate(const SetPinScreen());
      case RouteNames.confirmPinRoute:
        return navigate(ConfirmPinScreen(
          previousPin: settings.arguments as String,
        ));
      case RouteNames.entryPinRoute:
        return navigate(const EntryPinScreen());
      case RouteNames.touchId:
        return navigate(const BiometricScreen());


      case RouteNames.register:
        return navigate(const RegisterScreen());

      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String editProfileRoute = "/edit_profile_route";
  static const String tabRoute = "/tab_route";
  static const String register = "/register";
  static const String authRoute = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String setPinRoute = "/setPinRoute_route";
  static const String confirmPinRoute = "/confirmPinRoute_route";
  static const String entryPinRoute = "/entryPinRoute_route";
  static const String touchId = "/touchId_route";
}



SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  statusBarColor: AppColors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);
