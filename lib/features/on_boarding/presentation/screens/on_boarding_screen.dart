import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/gen/assets.gen.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_cubit.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_intents.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_side_effects.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_page_view1.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_page_view2.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_page_view3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late TextTheme textTheme;
  late OnBoardingCubit onBoardingCubit;
  final PageController _pageController = PageController();

  @override
  void initState() {
    onBoardingCubit = getIt<OnBoardingCubit>();
    onBoardingCubit.sideEffects.listen((event) {
      switch (event) {
        case ShowErrorSideEffect(message: final message):
          UIUtils.showMessage(
            message,
            backGroundColor: AppColors.red,
            textColor: AppColors.white,
          );
        case NavigateToLoginSideEffect():
          _navigateToLogin();
      }
    });
    super.initState();
  }

  void _navigateToLogin() {
    context.pushReplacementNamed(AppRoutesConstants.signInRoute);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  void _onDotTap(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => onBoardingCubit,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.onBoardingBackGround.path),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<OnBoardingCubit, OnBoardingStates>(
              buildWhen: (previous, current) =>
                  previous.currentPage != current.currentPage,
              builder: (context, state) {
                return Column(
                  children: [
                    Visibility(
                      visible: state.currentPage != 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 16),
                            child: InkWell(
                              onTap: () {
                                context.pushReplacementNamed(
                                  AppRoutesConstants.forgetPasswordRoute,
                                );
                              },
                              child: Text(
                                AppTextConstants.skip,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (page) {
                          onBoardingCubit.doIntent(
                            UpdateCurrentPageIntent(page),
                          );
                        },
                        children: [
                          OnBoardingPageView1(
                            onPressed: _nextPage,
                            onDotTap: _onDotTap,
                          ),
                          OnBoardingPageView2(
                            onPressedBack: _previousPage,
                            onPressedNext: _nextPage,
                            onDotTap: _onDotTap,
                          ),
                          OnBoardingPageView3(
                            onPressedBack: _previousPage,
                            onPressedNext: () {
                              onBoardingCubit.doIntent(NavigateToLoginIntent());
                            },
                            onDotTap: _onDotTap,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
