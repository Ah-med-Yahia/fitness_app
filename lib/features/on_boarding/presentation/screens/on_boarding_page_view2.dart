import 'package:fitness_app/app/core/gen/assets.gen.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/on_boarding/presentation/widgets/boarding_page.dart';
import 'package:fitness_app/features/on_boarding/presentation/widgets/row_buttons.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView2 extends StatelessWidget {
  const OnBoardingPageView2({
    super.key,
    required this.onPressedBack,
    required this.onPressedNext,
    required this.onDotTap,
  });
  final VoidCallback onPressedBack;
  final VoidCallback onPressedNext;
  final void Function(int)? onDotTap;

  @override
  Widget build(BuildContext context) {
    return BoardingPage(
      image: Assets.images.onboarding2.path,
      title: AppTextConstants.page2Title,
      onDotTap: onDotTap,
      description: AppTextConstants.page2Description,
      button: RowButtons(
        onPressedBack: onPressedBack,
        onPressedNext: onPressedNext,
        nextText: AppTextConstants.next,
      ),
    );
  }
}
