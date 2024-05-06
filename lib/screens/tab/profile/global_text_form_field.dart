import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';

class UniversalTextInput extends StatelessWidget {
  const UniversalTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.type,
    required this.regExp,
    required this.onChange,
    required this.errorTitle,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final RegExp regExp;
  final String errorTitle;
  final ValueChanged<String> onChange;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: TextFormField(
        onChanged: onChange,
        style: TextStyle(fontSize: 16.w, color: Colors.black),
        controller: controller,
        keyboardType: type,
        validator: (String? value) {
          if (value == null ||
              value.isEmpty ||
              value.length < 3 ||
              !regExp.hasMatch(value)) {
            return "Enter true $errorTitle";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16.w, color: Colors.black),
          hintText: hintText,
          labelText:hintText,
          labelStyle: TextStyle(fontSize: 16.w, color: Colors.black),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
