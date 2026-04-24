
import 'package:fitness_app/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/screens/login_screen.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.signInRoute,
    routes: [
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
