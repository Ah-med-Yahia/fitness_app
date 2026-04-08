import 'package:fitness_app/app/config/di/di.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/activity_level_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/age_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/gender_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/goal_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/height_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/login_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/register_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/screens/weight_screen.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:fitness_app/app/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      ShellRoute(
        builder: (context, state, child) =>
            BlocProvider(create: (_) => getIt<SignUpCubit>(), child: child),
        routes: [
          GoRoute(
            path: AppRoutesConstants.signUpRoute,
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(
            path: AppRoutesConstants.genderRoute,
            builder: (context, state) => const GenderScreen(),
          ),
          GoRoute(
            path: AppRoutesConstants.ageRoute,
            builder: (context, state) => const AgeScreen(),
          ),
          GoRoute(
            path: AppRoutesConstants.weightRoute,
            builder: (context, state) => const WeightScreen(),
          ),
          GoRoute(
            path: AppRoutesConstants.heightRoute,
            builder: (context, state) => const HeightScreen(),
          ),
          GoRoute(
            path: AppRoutesConstants.goalRoute,
            builder: (context, state) => const GoalScreen(),
          ),
          GoRoute(
            path: AppRoutesConstants.activityLevelRoute,
            builder: (context, state) => const ActivityLevelScreen(),
          ),
        ],
      ),
    ],
  );
}
