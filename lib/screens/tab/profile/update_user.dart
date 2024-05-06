import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/user_profile/user_profile_bloc.dart';
import '../../../blocs/user_profile/user_profile_event.dart';
import '../../../data/models/user_model.dart';
import '../../../utils/constants/app_constants.dart';
import 'global_button.dart';
import 'global_text_form_field.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late UserModel userModel;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  void initState() {
    userModel = widget.userModel;
    emailController.text = userModel.email;
    fullNameController.text = "${userModel.username} ${userModel.lastname}";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90.h,
              width: width,
            ),
            Align(
              alignment: Alignment.center,
              child: userModel.imageUrl.isNotEmpty
                  ? Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 60.w,
                        backgroundImage: NetworkImage(userModel.imageUrl),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  : Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 80.w,
                      ),
                    ),
            ),
            SizedBox(
              height: 20.h,
            ),
            UniversalTextInput(
              controller: emailController,
              hintText: "Email",
              type: TextInputType.emailAddress,
              regExp: AppConstants.emailRegExp,
              onChange: (v) {
                setState(() {});
              },
              errorTitle: "Invalid input",
            ),
            UniversalTextInput(
              controller: fullNameController,
              hintText: "Full name",
              type: TextInputType.text,
              regExp: AppConstants.textRegExp,
              onChange: (v) {
                setState(() {});
              },
              errorTitle: "Invalid input",
            ),
            SaveButton(
              onTab: () {
                context.read<UserProfileBloc>().add(
                      UpdateUserEvent(
                        userModel: userModel,
                      ),
                    );
                Navigator.pop(context);
              },
              active: checkInput,
              loading: false,
            ),
          ],
        ),
      ),
    );
  }

  bool get checkInput {
    return AppConstants.emailRegExp.hasMatch(emailController.text) &&
        AppConstants.textRegExp.hasMatch(fullNameController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
