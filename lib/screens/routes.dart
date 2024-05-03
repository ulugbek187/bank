import 'package:bank/screens/auth_login/login_screen.dart';
import 'package:bank/screens/auth_login/register_screen.dart';
import 'package:bank/screens/no_internet/no_internet_screen.dart';
import 'package:bank/screens/on_boarding/on_boarding_screen.dart';
import 'package:bank/screens/payment/payment_screen.dart';
import 'package:bank/screens/splash/splash_screen.dart';
import 'package:bank/screens/tab/tab_screen.dart';
import 'package:bank/screens/transfer/transfer_screen.dart';
import 'package:bank/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      case RouteNames.authRoute:
        return navigate(
          AuthScreen(
            // currentEmail: settings.arguments as String? ?? "",
          ),
        );

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
  static const String tabRoute = "/tab_route";
  static const String register = "/register";
  static const String authRoute = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
}



SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  statusBarColor: AppColors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);
