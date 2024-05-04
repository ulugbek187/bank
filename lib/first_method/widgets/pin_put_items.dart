import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPutItems extends StatelessWidget {
  const PinPutItems({
    super.key,
    required this.pinPutFocusMode,
    required this.pinPutController,
    required this.isError,
    this.onCompleted,
  });

  final FocusNode pinPutFocusMode;
  final TextEditingController pinPutController;
  final bool isError;
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    final defaultPnTheme = PinTheme(
        width: 42.w,
        height: 42.h,
        textStyle: const TextStyle(fontSize: 36, color: Colors.grey));
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.38,
      child: Pinput(
        useNativeKeyboard: false,
        showCursor: false,
        length: 4,
        onCompleted: onCompleted,
        defaultPinTheme: defaultPnTheme,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        focusNode: pinPutFocusMode,
        controller: pinPutController,
        errorPinTheme: PinTheme(
            width: 42.w,
            height: 42.h,
            textStyle: TextStyle(fontSize: 36.w, color: Colors.black)),
        preFilledWidget: Container(
          margin: const EdgeInsets.all(10),
          decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        ),
        obscureText: true,
        obscuringWidget: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isError ? Colors.red : Colors.green),
        ),
        followingPinTheme: defaultPnTheme,
        pinAnimationType: PinAnimationType.slide,
      ),
    );
  }
}
