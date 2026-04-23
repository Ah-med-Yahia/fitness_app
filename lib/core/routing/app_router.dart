import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.forgetPasswordRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.forgetPasswordRoute,
        name: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
