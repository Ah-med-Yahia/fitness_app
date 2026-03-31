import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.signInRoute,
    routes: [
    ],
  );
}