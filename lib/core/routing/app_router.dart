
import 'package:fitness_app/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/screens/login_screen.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.forgetPasswordRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.forgetPasswordRoute,
        name: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.signInRoute,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
    ],
  );
}
