import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/core/app/providers/user_provider.dart';
import 'package:school_app/core/common/page_under_construction.dart';
import 'package:school_app/core/extensions/context_extension.dart';
import 'package:school_app/core/services/injection_container.dart';
import 'package:school_app/src/auth/data/models/local_user_model.dart';
import 'package:school_app/src/auth/presentation/bloc/auth_bloc.dart';

import 'package:school_app/src/auth/presentation/views/sign_in.dart';
import 'package:school_app/src/auth/presentation/views/sign_up.dart';
import 'package:school_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:school_app/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:school_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:school_app/src/on_boarding/presentation/view/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      final ref = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          final user = sl<FirebaseAuth>().currentUser;

          if (ref.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (context) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (user != null) {
            final userDetails = LocalUserModel(
              email: user.email ?? '',
              fullName: user.displayName ?? '',
              profilePic: user.photoURL ?? '',
            );

            context.userProvider.initUser(userDetails);

            return const Dashboard();
          } else {
            return BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const SignInScreen(),
            );
          }
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );

    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );

    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const UnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
