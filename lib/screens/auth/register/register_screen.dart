import 'package:bank/blocs/auth/auth_bloc.dart';
import 'package:bank/blocs/auth/auth_event.dart';
import 'package:bank/blocs/auth/auth_state.dart';
import 'package:bank/data/models/form_status.dart';
import 'package:bank/data/models/user_model.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = true;
  bool isSecondVisible = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstPasswordController =
      TextEditingController();
  final TextEditingController _secondPasswordController =
      TextEditingController();

  String firstPassword = '';
  String secondPassword = '';

  @override
  void dispose() {
    _emailController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
    _userNameController.dispose();
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
            return Container(
              height: MediaQuery.sizeOf(
                context,
              ).height,
              width: MediaQuery.sizeOf(
                context,
              ).width,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      Image.asset(
                        AppImages.register,
                        width: 350.w,
                        height: 200.h,
                      ),
                      SizedBox(height: 30.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextField(
                                type: TextInputType.name,
                                iconPath: AppImages.user,
                                hinText: "User name",
                                onChanged: (v) {},
                                regExp: AppConstants.textRegExp,
                                errorText: "Ismingizni togri kiriting",
                                controller: _userNameController),
                            SizedBox(height: 24.h),
                            MyTextField(
                                type: TextInputType.emailAddress,
                                iconPath: AppImages.user,
                                hinText: "Email",
                                onChanged: (v) {},
                                regExp: AppConstants.emailRegExp,
                                errorText: "Emailni togri kiriting",
                                controller: _emailController),
                            SizedBox(height: 24.h),
                            MyTextField(
                              type: TextInputType.visiblePassword,
                              iconPath: AppImages.lock,
                              hinText: "Password",
                              onChanged: (v) {
                                firstPassword = v;
                              },
                              regExp: AppConstants.passwordRegExp,
                              errorText: "Parol unikal bolishi kerak",
                              controller: _firstPasswordController,
                            ),
                            SizedBox(height: 24.h),
                            // TextFormField(
                            //   obscureText: isSecondVisible,
                            //   onChanged: (v) {
                            //     secondPassword = v;
                            //   },
                            //   keyboardType: TextInputType.visiblePassword,
                            //   textInputAction: TextInputAction.done,
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   controller: _secondPasswordController,
                            //   validator: (String? value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "WRONG PASSWORD!!!";
                            //     } else if (firstPassword != secondPassword) {
                            //       return "BOTH PASSWORDS MUST MATCH!!!";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //     labelText: "Confirm Password",
                            //     labelStyle: AppTextStyle.interBold.copyWith(
                            //       fontSize: 15.w,
                            //       fontWeight: FontWeight.w500,
                            //       color: AppColors.c676767,
                            //     ),
                            //     suffixIcon: IconButton(
                            //       icon: SvgPicture.asset(
                            //         isVisible
                            //             ? AppImages.eye
                            //             : AppImages.eyeUnVisible,
                            //         width: 25.w,
                            //         height: 25.h,
                            //         fit: BoxFit.fill,
                            //         colorFilter: const ColorFilter.mode(
                            //           Colors.black,
                            //           BlendMode.srcIn,
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         isSecondVisible = !isSecondVisible;
                            //         setState(() {});
                            //       },
                            //     ),
                            //     prefixIcon: Icon(
                            //       Icons.lock,
                            //       size: 30.w,
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(
                            //         10,
                            //       ),
                            //       borderSide: const BorderSide(
                            //         color: AppColors.cA8A8A9,
                            //         width: 1,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            MyTextField(
                              type: TextInputType.visiblePassword,
                              iconPath: AppImages.lock,
                              hinText: "Confirm Password",
                              onChanged: (v) {
                                secondPassword = v;
                              },
                              regExp: AppConstants.passwordRegExp,
                              errorText:
                                  "Kiritgan kodingiz unikal bolishi kerak",
                              controller: _secondPasswordController,
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h,),
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    RegisterUserEvent(
                                      userModel: UserModel(
                                        username: _userNameController.text,
                                        lastname: _userNameController.text,
                                        password: _firstPasswordController.text,
                                        userId: "",
                                        imageUrl: '',
                                        phoneNumber:
                                            _secondPasswordController.text,
                                        email: _emailController.text,
                                        fcmToken: '',
                                        authUUId: '',
                                      ),
                                    ),
                                  );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: const Duration(
                                    seconds: 3,
                                  ),
                                  content: Text(
                                    "SUCCESS",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.interSemiBold,
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: const Duration(
                                    seconds: 3,
                                  ),
                                  content: Text(
                                    "SUCCESS",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.interSemiBold,
                                  ),
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
                            // Navigator.pushReplacementNamed(
                            //     context, RouteNames.tabRoute);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Container(
                              height: 50.h,
                              width: double.infinity,
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
                                  "Create Account",
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
                      SizedBox(height: 20.h),
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
                                      MainAxisAlignment.center,
                                  children: [

                                    SvgPicture.asset(
                                      AppImages.google,
                                      height: 30.w,
                                      width: 30.w,
                                    ),
                                    Text(
                                      " Google",
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
                      SizedBox(height: 20.h),
                      Padding(
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
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.authRoute,
                                arguments: '',
                              );
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: AppTextStyle.interBold.copyWith(
                                  fontSize: 17.w,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                SnackBar(content: Text(state.errorMessage)),
              );
            }
            if (state.formStatus == FormStatus.authenticated) {
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   RouteNames.authRoute,
              //   arguments:
              //       "${_userNameController.text.toLowerCase()}@gmail.com",
              //   (route) => false,
              // );
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
