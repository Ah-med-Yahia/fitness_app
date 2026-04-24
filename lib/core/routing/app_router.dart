import 'package:fitness_app/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:fitness_app/features/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../feature/food/presentation/view/meal_details_screen.dart';
import '../../features/auth/presentation/view/screens/login_screen.dart';

import '../../feature/food_category/presentation/view/categories_screen.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.splashRoute,
        name: AppRoutesConstants.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.onBoardingRoute,
        name: AppRoutesConstants.onBoardingRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgetPasswordRoute,
        name: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.signInRoute,
        name: AppRoutesConstants.signInRoute,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutesConstants.foodCategoryRoute,
        builder: (context, state) {
          return const CategoriesScreen();
        },
      ),
      GoRoute(
        path: '${AppRoutesConstants.foodDetailsRoute}/:id',
        name: AppRoutesConstants.foodDetailsRoute,
        builder: (context, state) {
          final mealId = state.pathParameters['id'];
          return MealDetailsScreen(mealId: mealId ?? '');
        },
      ),
    ],
  );
}
