// import 'dart:io';
// import 'package:bank/provider/auth_view_model.dart';
// import 'package:bank/screens/auth_login/widgets/my_text_field.dart';
// import 'package:bank/screens/routes.dart';
// import 'package:bank/screens/tab/tab_screen.dart';
// import 'package:bank/utils/colors/app_colors.dart';
// import 'package:bank/utils/constants/app_constants.dart';
// import 'package:bank/utils/images/app_images.dart';
// import 'package:bank/utils/styles/app_text_style.dart';
// import 'package:bank_app/bank_app.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});
//
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: AppColors.transparent,
//         statusBarBrightness: Brightness.light,
//         statusBarIconBrightness: Brightness.light,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: context.watch<AuthViewModel>().loading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 24.w,
//                   vertical: 24.h,
//                 ),
//                 child: ListView(
//                   children: [
//                     Image.asset(AppImages.login, height: 165.h,width: 200.w,),
//                     Text(
//                       "LOGIN",
//                       textAlign: TextAlign.center,
//                       style: AppTextStyle.interSemiBold.copyWith(
//                         fontSize: 32.w,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     MyTextField(
//                       onChanged: (v) {},
//                       controller: emailController,
//                       hinText: "Email",
//                       type: TextInputType.text,
//                       iconPath: AppImages.email,
//                       regExp: AppConstants.emailRegExp,
//                       errorText: 'Emailni togri kiriting',
//                     ),
//                     SizedBox(
//                       height: 24.h,
//                     ),
//                     MyTextField(
//                       onChanged: (v) {},
//                       type: TextInputType.text,
//                       iconPath: AppImages.lock,
//                       hinText: 'Password',
//                       regExp: AppConstants.passwordRegExp,
//                       errorText: 'Kodni togri kiriting',
//                       controller: passwordController,
//                     ),
//                     Container(
//                       height: 60.h,
//                       width: double.infinity,
//                       margin: EdgeInsets.only(
//                         top: 24.h,
//                         left: 24.w,
//                         right: 24.w,
//                       ),
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                               16.w,
//                             ),
//                           ),
//                         ),
//                         onPressed: () async {
//                           await context.read<AuthViewModel>().loginUser(
//                                 context,
//                                 email: emailController.text,
//                                 password: passwordController.text,
//                               );
//                         },
//                         child: Text(
//                           "LOGIN",
//                           style: AppTextStyle.interSemiBold.copyWith(
//                             fontSize: 24,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 60.h,
//                       width: double.infinity,
//                       margin: EdgeInsets.only(
//                         top: 24.h,
//                         left: 24.w,
//                         right: 24.w,
//                       ),
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                               16.w,
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(
//                             context,
//                             RouteNames.register,
//                           );
//                         },
//                         child: Text(
//                           "REGISTER",
//                           style: AppTextStyle.interSemiBold.copyWith(
//                             fontSize: 24,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 60.h,
//                       width: double.infinity,
//                       margin: EdgeInsets.symmetric(
//                         horizontal: 24.w,
//                         vertical: 24.h,
//                       ),
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                               16.w,
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           context.read<AuthViewModel>().signInWithGoogle(
//                                 context,
//                                 Platform.isAndroid
//                                     ? null
//                                     : AppConstants.clientID,
//                               );
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabScreen()));
//                         },
//                         child: Text(
//                           "LOGIN WITH GOOGLE",
//                           style: AppTextStyle.interSemiBold.copyWith(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
