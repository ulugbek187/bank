// import 'package:bank/blocs/auth/auth_bloc.dart';
// import 'package:bank/blocs/user_profile/user_profile_bloc.dart';
// import 'package:bank/data/repositories/auth_repository.dart';
// import 'package:bank/data/repositories/user_profile_repo/user_profile_repo.dart';
// import 'package:bank/provider/auth_view_model.dart';
// import 'package:bank/screens/routes.dart';
// import 'package:bank/services/local_notification_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
//
// class App extends StatelessWidget {
//   App({super.key});
//
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     LocalNotificationService.localNotificationService.init(navigatorKey);
//     return MultiRepositoryProvider(
//       providers: [
//         // MultiProvider(
//         //   providers: [
//         //     ChangeNotifierProvider(
//         //       create: (_) => AuthViewModel(),
//         //     ),
//         //   ],
//         // ),
//         RepositoryProvider(
//           create: (_) => AuthRepository(),
//         ),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => AuthBloc(
//               authRepository: context.read<AuthRepository>(),
//             ),
//           ),
//           BlocProvider(
//             create: (context) => UserProfileBloc(
//               context.read<UserProfileRepo>(),
//             ),
//           ),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           initialRoute: RouteNames.splashScreen,
//           navigatorKey: navigatorKey,
//           onGenerateRoute: AppRoutes.generateRoute,
//         ),
//       ),
//     );
//   }
// }


import 'package:bank/blocs/auth/auth_bloc.dart';
import 'package:bank/blocs/user_profile/user_profile_bloc.dart';
import 'package:bank/data/repositories/auth_repository.dart';
import 'package:bank/data/repositories/user_profile_repo/user_profile_repo.dart';
import 'package:bank/screens/routes.dart';
import 'package:bank/services/local_notification_service.dart';
import 'package:bank/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(
      BuildContext context,
      ) {
    LocalNotificationService.localNotificationService.init(
      navigatorKey,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => UserProfileRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userProfileRepo: context.read<UserProfileRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(
              context.read<UserProfileRepo>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.white,
            ),
            scaffoldBackgroundColor: AppColors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
