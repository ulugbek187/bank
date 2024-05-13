import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../blocs/user_profile/user_profile_bloc.dart';
import '../../../blocs/user_profile/user_profile_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.editProfileRoute,
                arguments: context.read<UserProfileBloc>().state.userModel,
              );
            },
            icon: Icon(
              Icons.edit,
              size: 24.w,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authRoute, (route) => false);
              context.read<AuthBloc>().add(LogOutUserEvent());
            },
            icon: Icon(
              Icons.exit_to_app,
              size: 24.w,
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (BuildContext context, UserProfileState state) {

          return Column(
            children: [
              SizedBox(
                height: 20.w,
              ),
              Align(
                alignment: Alignment.center,
                child: state.userModel.imageUrl.isNotEmpty
                    ? Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 60.w,
                          backgroundImage: NetworkImage(
                            state.userModel.imageUrl,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    : Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 80.w,
                        ),
                      ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                state.userModel.lastname,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 30.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                          ),
                          Text(
                            "Email: ${state.userModel.email}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Last name: ${state.userModel.lastname}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "First name: ${state.userModel.username}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Phone number: ${state.userModel.phoneNumber}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.securityRoute,
                              );
                            },
                            child: Container(
                              width: width,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(
                                  8.w,
                                ),
                                border: Border.all(
                                  width: 3.w,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Text(
                                "Security",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 24.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
