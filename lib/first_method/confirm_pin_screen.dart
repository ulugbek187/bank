import 'dart:async';
import 'package:bank/first_method/widgets/key_board.dart';
import 'package:bank/first_method/widgets/pin_put_items.dart';
import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:pinput/pinput.dart';
import '../../../data/local/storage_repository.dart';
import '../../../utils/styles/app_text_style.dart';
import '../data/repositories/user_profile_repo/user_profile_repo.dart';
import '../screens/routes.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.previousPin});

  final String previousPin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;
  bool isBiometricsEnabled = false;

  @override
  void initState() {
    BiometricAuthService.canAuthenticate().then(
      (value) {
        if (value) {
          isBiometricsEnabled = true;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry pin"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.h,),
          Text(
            "Pin kodlar  O'mos emas!",
            style: AppTextStyle.interMedium.copyWith(fontSize: 20),
          ),
          SizedBox(height: 32.h,),
          SizedBox(
            width: width / 2,
            child: PinPutItems(
                pinPutFocusMode: focusNode,
                pinPutController: pinPutController,
                isError: isError),
          ),
         SizedBox(height: 32.h,),
          CustomKeyboard(
            number: (number) {
              if (pinPutController.length < 4) {
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (widget.previousPin == pinPutController.text) {
                  _setPin(pinPutController.text);
                } else {
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
            },
            isBiometricsEnabled: false,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text
                    .substring(0, pinPutController.text.length - 1);
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(key: "pin_code", value: pin);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context,
        isBiometricsEnabled ? RouteNames.touchId : RouteNames.tabRoute,
        (route) => false);
  }
}

class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    final bool canAuthenticateBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate =
        canAuthenticateBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      List<BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) return true;
    }

    return false;
  }

  static Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
          localizedReason: "Barmoq izini faollashtiring",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
            biometricOnly: true,
          ));
    } on PlatformException catch (e) {
      methodPrint("Biometrics Error:${e.code}");
      if (e.code == auth_error.notAvailable) {
        methodPrint("BIOMETRIC AUTH NOT SUPPORTED");
      } else if (e.code == auth_error.notEnrolled) {
        methodPrint("BIOMETRIC AUTH NOT SUPPORTED USE");
      } else {
        methodPrint("SOMETHING WRONG");
      }
      return false;
    }
  }
}