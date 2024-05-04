import 'package:bank/blocs/user_profile/user_profile_bloc.dart';
import 'package:bank/blocs/user_profile/user_profile_event.dart';
import 'package:bank/blocs/user_profile/user_profile_state.dart';
import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_state.dart';
import '../../../data/models/form_status.dart';
import '../../../utils/styles/app_text_style.dart';
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
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.formStatus == FormStatus.unauthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.authRoute,
                    (route) => false,
                  );
                }
              },
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.editProfileRoute,
                      arguments: () {
                    BlocProvider.of<UserProfileBloc>(context).add(
                      GetCurrentUserEvent(),
                    );
                  });
                },
                icon: Icon(
                  Icons.edit,
                  size: 20.w,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
          centerTitle: true,
          title: const Text(
            "Profile Screen",
          ),
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state.formStatus == FormStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: AppTextStyle.interBold,
                ),
              );
            }
            if (state.formStatus == FormStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.formStatus == FormStatus.success) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   state.userModel.imageUrl,
                    //   height: 50.h,
                    //   width: 100.w,
                    // ),
                    Text(
                      "Your Gmail Link: | ${state.userModel.email}",
                      style: AppTextStyle.interSemiBold,
                    ),
                    Text(
                      "Your First Name: | ${state.userModel.username}",
                      style: AppTextStyle.interSemiBold,
                    ),
                    Text(
                      "Your Last Name: | ${state.userModel.lastname}",
                      style: AppTextStyle.interSemiBold,
                    ),
                    Text(
                      "Your password: | ${state.userModel.password}",
                      style: AppTextStyle.interSemiBold,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
