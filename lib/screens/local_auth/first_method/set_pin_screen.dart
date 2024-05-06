import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../utils/colors/app_colors.dart';
import '../../routes.dart';
import '../widgets/global_button.dart';
import '../widgets/pin_item.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
            "Pin Kodni o'rnating",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18.w,
            ),
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
            height: 40.h,
          ),
          CustomKeyboardView(
            number: (number) {
              if (pinController.length < 4) {
                pinController.text += number;
              }
              if (pinController.length == 4) {
                Navigator.pushNamed(context, RouteNames.confirmPinRoute,
                    arguments: pinController.text);
                pinController.text = '';
              }
            },
            isBiometric: true,
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
}
