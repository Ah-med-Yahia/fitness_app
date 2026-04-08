import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../view_model/signup/signup_cubit.dart';
import '../widgets/onboarding_scaffold.dart';
import '../widgets/option_radio_tile.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String? _selectedGoal;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      stepLabel: SignUpConstants.goalStepLabel,
      stepProgress: 5 / 6,
      title: SignUpConstants.goalTitle,
      subtitle: SignUpConstants.onboardingSub,
      onNext: _selectedGoal == null
          ? null
          : () {
              context.read<SignUpCubit>().updateFormData(
                context.read<SignUpCubit>().formData.copyWith(
                  goal: _selectedGoal,
                ),
              );
              context.push(AppRoutesConstants.activityLevelRoute);
            },
      cardContent: Column(
        children: SignUpConstants.goalOptions
            .map(
              (option) => OptionRadioTile(
                label: option,
                isSelected: _selectedGoal == option,
                onTap: () => setState(() => _selectedGoal = option),
              ),
            )
            .toList(),
      ),
    );
  }
}
