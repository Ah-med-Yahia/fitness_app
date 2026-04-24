import 'package:dots_indicator/dots_indicator.dart';
import 'package:fitness_app/core/shared/presentation/widgets/blurred_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Footer extends StatelessWidget {
  final String title;
  final String description;
  final void Function(int)? onDotTap;
  final Widget buttton;
  const Footer({
    super.key,
    required this.title,
    required this.onDotTap,
    required this.description,
    required this.buttton,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlurredCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(description, style: textTheme.bodyMedium),
          const SizedBox(height: 24),
          BlocBuilder<OnBoardingCubit, OnBoardingStates>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage,
            builder: (context, state) {
              return DotsIndicator(
                dotsCount: 3,
                position: state.currentPage.toDouble(),
                onTap: onDotTap,
                decorator: const DotsDecorator(
                  size: Size(8, 8),
                  activeSize: Size(20, 8),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
                  ),
                  activeColor: AppColors.primary,
                  color: AppColors.white,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          buttton,
        ],
      ),
    );
  }
}
