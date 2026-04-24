import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/get_app_status_use_case.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/splash/presentation/splash_cubit.dart';
import 'package:fitness_app/features/splash/presentation/splash_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: BlocListener<SplashCubit, SplashStates>(
          listener: (context, state) {
            if (state.userInitialStatus != null) {
              switch (state.userInitialStatus!) {
                case UserInitialStatus.newUser:
                  context.pushReplacementNamed(
                    AppRoutesConstants.onBoardingRoute,
                  );
                case UserInitialStatus.notLoggedIn:
                  context.pushReplacementNamed(AppRoutesConstants.signInRoute);
                case UserInitialStatus.loggedIn:
                  context.pushReplacementNamed(AppRoutesConstants.mainRoute);
              }
            }
          },
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
