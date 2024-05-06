import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pinput.dart';
import '../../../data/local/storage_repository.dart';
import '../../routes.dart';
import '../widgets/global_button.dart';
import '../widgets/pin_item.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.pin});

  final String pin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;
  bool biometric = false;

  @override
  void initState() {
    BiometricAuthService.canAuthenticated().then((value) {
      if (value) {
        biometric = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Text(
            "Pin Kodni qaytadan kiriting",
            style: TextStyle(fontSize: 18.w, color: Colors.black),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            width: width / 2,
            child: PinItem(
              pinPutFocusNode: focusNode,
              pinPutController: pinController,
              isError: isError,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            (!isError) ? "" : "Pin oldingisi bilan mos emas",
            style: TextStyle(fontSize: 18.w, color: Colors.red),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomKeyboardView(
            number: (number) {
              if (pinController.length < 4) {
                isError = false;
                pinController.text += number;
              }
              if (pinController.length == 4) {
                if (widget.pin == pinController.text) {
                  _setPin(pinController.text);
                } else {
                  isError = true;
                  pinController.clear();
                }
              }
              setState(() {});
            },
            isBiometric: false,
            onClearButton: () {
              if (pinController.length > 0) {
                pinController.text = pinController.text
                    .substring(0, pinController.text.length - 1);
              }
            },
            onFingerButton: () {},
          )
        ],
      ),
    );
  }

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(key: 'pin', value: pin);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context,
        (biometric) ? RouteNames.touchId : RouteNames.tabRoute,
        (route) => false);
  }
}




class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticated() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      List<BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> authenticate() async {
    try {
      debugPrint("AAA");
      debugPrint("AAaaa${await auth.authenticate(
          localizedReason:"Barmoq izini faollashtirish",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            sensitiveTransaction: false,
            stickyAuth: true,
            biometricOnly: true,
          ))}");
      return await auth.authenticate(
          localizedReason:"Barmoq izini faollashtirish",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
            biometricOnly: true,
          ));
    }
    catch (e) {
      return false;
    }
  }
}
