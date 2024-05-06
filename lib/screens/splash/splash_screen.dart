import 'package:bank_app/bank_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/local/storage_repository.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasPin = StorageRepository.getString(key: "pin").isNotEmpty;

  _init() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      bool isNewUser = StorageRepository.getBool(
        key: "is_new_user",
      );
      if (isNewUser) {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.authRoute,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.onBoardingRoute,
        );
      }
    } else {
      hasPin
          ? Navigator.pushReplacementNamed(context, RouteNames.entryPinRoute)
          : Navigator.pushReplacementNamed(
              context,
              RouteNames.setPinRoute,
            );
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(
      context,
    ).size.width;
    height = MediaQuery.of(
      context,
    ).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: AppColors.authContainerGradient,
        ),
        child: Center(
          child: Image.asset(
            AppImages.history,
          ),
        ),
      ),
    );
  }
}
