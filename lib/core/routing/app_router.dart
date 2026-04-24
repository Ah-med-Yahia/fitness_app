import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:fitness_app/splash_screen.dart';
import 'package:go_router/go_router.dart';

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
    ],
  );
}
