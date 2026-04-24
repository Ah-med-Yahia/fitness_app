
import 'package:fitness_app/features/auth/presentation/view_model/login_cubit.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/food/presentation/view/meal_details_screen.dart';
import '../../features/auth/presentation/view/screens/login_screen.dart';

import '../../feature/food_category/presentation/view/categories_screen.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.signInRoute,
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
      GoRoute(
        path: AppRoutesConstants.foodCategoryRoute,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const CategoriesScreen(),
        ),
      ),

    ],
  );
}
class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesConstants.foodCategoryRoute:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
        default
        : return unDefinedRoute();
    //   case Routes.splash:
    //     return MaterialPageRoute(builder: (_) => const SplashScreen());
    //
    //   case Routes.login:
    //     return MaterialPageRoute(builder: (_) => LoginScreen());
    //
    //   case Routes.register:
    //     return MaterialPageRoute(builder: (_) => SignupScreen());
    //
    //   case Routes.forgetPassword:
    //     return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
    //
    //   case Routes.verifyOtp:
    //     final email = settings.arguments;
    //     if (email is String) {
    //       return MaterialPageRoute(
    //         builder: (_) => VerifyOtpScreen(email),
    //         settings: settings,
    //       );
    //     }
    //     return unDefinedRoute();
    //
    //   case Routes.resetPassword:
    //     final email = settings.arguments;
    //     if (email is String) {
    //       return MaterialPageRoute(
    //         builder: (_) => ResetPasswordScreen(email),
    //         settings: settings,
    //       );
    //     }
    //     return unDefinedRoute();
    //
    //   case Routes.home:
    //     return MaterialPageRoute(builder: (_) => const HomeScreen());
    //
    //   case Routes.occasion:
    //     return MaterialPageRoute(builder: (_) => const OccasionScreen());
    //
    //   case Routes.bestSeller:
    //     return MaterialPageRoute(builder: (_) => const BestSellerScreen());
    //
    //   case Routes.productDetails:
    //     final args = settings.arguments as String?;
    //     return MaterialPageRoute(
    //       builder: (_) => ProductDetailsScreen(productId: args),
    //       settings: settings,
    //     );
    //
    //   case Routes.addressDetails:
    //     final args = settings.arguments;
    //     if (args is UserAddressEntity? || args == null) {
    //       return MaterialPageRoute(
    //         builder: (_) => AddressDetailsScreen(userAddressEntity: args),
    //         settings: settings,
    //       );
    //     }
    //     return unDefinedRoute();
    //
    //   case Routes.userAddress:
    //     return MaterialPageRoute(builder: (_) => const AddressScreen());
    //
    //   case Routes.updateProfile:
    //     final userEntity = settings.arguments;
    //     if (userEntity is UserEntity) {
    //       return MaterialPageRoute(
    //         builder: (_) => UpdateProfileWidget(user: userEntity),
    //         settings: settings,
    //       );
    //     }
    //     return unDefinedRoute();
    //
    //   case Routes.changePassword:
    //     return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
    //
    //   case Routes.aboutApp:
    //     return MaterialPageRoute(builder: (_) => const AboutAppScreen());
    //
    //   case Routes.terms:
    //     return MaterialPageRoute(
    //       builder: (_) => const TermsAndConditionsScreen(),
    //     );
    //
    //   case Routes.checkOut:
    //     return MaterialPageRoute(
    //       builder: (_) => const CheckOutScreen(),
    //       settings: settings,
    //     );
    //
    //   case Routes.search:
    //     return MaterialPageRoute(builder: (_) => const SearchScreen());
    //
    //   case Routes.onlinePayment:
    //     return MaterialPageRoute(
    //       builder: (_) => const OnlinePaymentWebViewScreen(),
    //       settings: settings,
    //     );
    //
    //   default:
    //     return unDefinedRoute();
     }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
