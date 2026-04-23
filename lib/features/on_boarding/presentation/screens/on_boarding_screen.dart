import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/gen/assets.gen.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_cubit.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_intents.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_page_view1.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_page_view2.dart';
import 'package:fitness_app/features/on_boarding/presentation/screens/on_boarding_page_view3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    onBoardingCubit = getIt<OnBoardingCubit>();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
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
            child: Column(
              children: [
                BlocBuilder<OnBoardingCubit, OnBoardingStates>(
                  buildWhen: (previous, current) =>
                      previous.currentPage != current.currentPage,
                  builder: (context, state) {
                    return Visibility(
                      visible: state.currentPage != 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 16),
                            child: InkWell(
                              onTap: () {
                                _nextPage();
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
                    );
                  },
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      onBoardingCubit.doIntent(UpdateCurrentPageIntent(page));
                    },
                    children: const [
                      OnBoardingPageView1(),
                      OnBoardingPageView2(),
                      OnBoardingPageView3(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
