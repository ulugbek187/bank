import 'package:bank/blocs/auth/auth_bloc.dart';
import 'package:bank/blocs/auth/auth_state.dart';
import 'package:bank/data/models/form_status.dart';
import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user_profile/user_profile_bloc.dart';
import '../../blocs/user_profile/user_profile_event.dart';
import '../../data/local/storage_repository.dart';
import '../../utils/images/app_images.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasPin = false;

  _init(bool isAuthenticated) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;
    if (isAuthenticated == false) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.authRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      }
    } else {
      Navigator.pushReplacementNamed(
          context, hasPin ? RouteNames.entryPinRoute : RouteNames.setPinRoute);
    }
  }

  //
  @override
  void initState() {
    hasPin = StorageRepository.getString(key: "pin_code").isNotEmpty;
    _init(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.formStatus == FormStatus.authenticated) {
              BlocProvider.of<UserProfileBloc>(context).add(GetCurrentUserEvent());
              _init(true);
            } else {
              _init(false);
            }
          },
          child: Center(
            child: Image.asset(
              AppImages.login,
            ),
          ),
        ));
  }
}
