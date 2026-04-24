import 'package:fitness_app/config/di/di.dart';

import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_side_effects.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/email_page_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/reset_password_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/screens/verify_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/core/gen/assets.gen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final PageController _pageController = PageController();
  late final ForgetPasswordCubit _cubit;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ForgetPasswordCubit>();
    _cubit.sideEffects.listen((event) {
      if (mounted) {
        switch (event) {
          case ShowLoading():
            _handleShowLoading();
          case HideLoading():
            _handleHideLoading();
          case ShowError():
            _handleShowError(event.error);
          case ShowSuccessMessage():
            _handleShowSuccessMessage(event.message);
          case NavigateToNextPageViewSideEffect():
            _handleNavigateToNextPageView();
          case NavigateToLoginSideEffect():
            _handleNavigateToLogin();
        }
      }
    });
  }

  void _handleShowLoading() {
    UIUtils.showEasyLoading();
  }

  void _handleHideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _handleShowError(String error) {
    UIUtils.showMessage(
      error,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  void _handleShowSuccessMessage(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  void _handleNavigateToNextPageView() {
    _nextPage();
  }

  void _handleNavigateToLogin() {
    context.pushReplacementNamed(AppRoutesConstants.signInRoute);
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.authBackground.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              AppBar(
                backgroundColor: AppColors.transparent,
                leading: InkWell(
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.pop();
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                    size: 35,
                  ),
                ),
                title: Image.asset(
                  Assets.images.fitnessAppBar.path,
                  height: 75,
                  width: 90,
                ),
              ),
              SizedBox(height: size.height * .1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      EmailPageView(),
                      VerifyCodeView(),
                      ResetPasswordView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
