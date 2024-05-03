import 'package:bank/blocs/auth/auth_bloc.dart';
import 'package:bank/blocs/auth/auth_event.dart';
import 'package:bank/blocs/auth/auth_state.dart';
import 'package:bank/data/models/form_status.dart';
import 'package:bank/screens/auth_login/widgets/my_text_field.dart';
import 'package:bank/screens/routes.dart';
import 'package:bank/utils/colors/app_colors.dart';
import 'package:bank/utils/constants/app_constants.dart';
import 'package:bank/utils/images/app_images.dart';
import 'package:bank/utils/styles/app_text_style.dart';
import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.currentEmail,
  });

  final String currentEmail;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            if (widget.currentEmail.isNotEmpty) {
              _userNameController.text = widget.currentEmail;
            }
            return Container(
              height: MediaQuery.sizeOf(
                context,
              ).height,
              width: MediaQuery.sizeOf(
                context,
              ).width,
              decoration: const BoxDecoration(color: Colors.black),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      Image.asset(
                        AppImages.login,
                        width: 350.w,
                        height: 200.h,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextField(
                                type: TextInputType.emailAddress,
                                iconPath: AppImages.user,
                                hinText: "Email",
                                onChanged: (v) {},
                                regExp: AppConstants.emailRegExp,
                                errorText: "Emailni Togri kiriting",
                                controller: _userNameController),
                            SizedBox(
                              height: 24.h,
                            ),
                            MyTextField(
                                type: TextInputType.name,
                                iconPath: AppImages.lock,
                                hinText: "Password",
                                onChanged: (v) {},
                                regExp: AppConstants.passwordRegExp,
                                errorText: "Kiritgan kodingiz notogri",
                                controller: _passwordController),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    LoginUserEvent(
                                      username: _userNameController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: const Duration(
                                    seconds: 3,
                                  ),
                                  content: Text(
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.interSemiBold,
                                    "PLEASE ENTER ALL LINES CORRECTLY AND COMPLETELY!!!",
                                  ),
                                ),
                              );
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 70.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  ),
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                        0.25,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(
                                        0,
                                        4,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: AppTextStyle.interBlack.copyWith(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 70.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.25,
                                ),
                                blurRadius: 4,
                                offset: const Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.register,
                              );
                            },
                            child: Center(
                              child: Text(
                                "Register Now",
                                style: AppTextStyle.interBold.copyWith(
                                  fontSize: 17.w,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            onTap: () {
                              context.read<AuthBloc>().add(
                                    SignInWithGoogleUserEvent(),
                                  );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 30.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                                gradient: AppColors.loginWithGoogleGradient,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.google,
                                      height: 30.w,
                                      width: 30.w,
                                    ),
                                    Text(
                                      "Login with Google",
                                      style: AppTextStyle.interBold.copyWith(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state.formStatus == FormStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            }
            if (state.formStatus == FormStatus.authenticated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
