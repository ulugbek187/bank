import 'package:bank/first_method/widgets/key_board.dart';
import 'package:bank/first_method/widgets/pin_put_items.dart';
import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../screens/routes.dart';
import '../utils/styles/app_text_style.dart';


class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry pin"),
      ),
      body: Column(
        children: [
          SizedBox(height: 60.h,),
          Text(
            "Pin kodni O'rnating!",
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
                Navigator.pushNamed(context, RouteNames.confirmPinRoute,
                    arguments: pinPutController.text);
                pinPutController.text = "";
              }
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
}
