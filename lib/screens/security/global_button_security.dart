import 'package:bank_app/bank_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors/app_colors.dart';

class SecurityButton extends StatelessWidget {
  const SecurityButton(
      {super.key, required this.isEnabled, required this.onTab});

  final bool isEnabled;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTab,
        style: TextButton.styleFrom(
            backgroundColor: AppColors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Row(
          children: [
            Text(
              "Biometrics",
              style:TextStyle(fontSize: 18.w,color: Colors.black),
            ),
            const Spacer(),
            CupertinoSwitch(
                value: isEnabled,
                autofocus: true,
                onChanged: (v) {
                  onTab.call();
                })
          ],
        ));
  }
}