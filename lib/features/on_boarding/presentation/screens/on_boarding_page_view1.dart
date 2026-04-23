import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/gen/assets.gen.dart';
import 'package:fitness_app/features/on_boarding/presentation/widgets/boarding_page.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView1 extends StatelessWidget {
  const OnBoardingPageView1({super.key});

  @override
  Widget build(BuildContext context) {
    return BoardingPage(
      image: Assets.images.onboarding1.path,
      title: AppTextConstants.page1Title,
      description: AppTextConstants.page1Description,
      button: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(AppTextConstants.next),
        ),
      ),
    );
  }
}
