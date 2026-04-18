import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../view_model/signup/signup_cubit.dart';
import '../widgets/onboarding_scaffold.dart';
import '../widgets/wheel_picker_content.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  int _selectedWeight = 70;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      stepLabel: SignUpConstants.weightStepLabel,
      stepProgress: 3 / 6,
      title: SignUpConstants.weightTitle,
      subtitle: SignUpConstants.onboardingSub,
      onNext: () {
        context.read<SignUpCubit>().updateFormData(
          context.read<SignUpCubit>().formData.copyWith(
            weight: _selectedWeight,
          ),
        );
        context.push(AppRoutesConstants.heightRoute);
      },
      cardContent: WheelPickerContent(
        unit: SignUpConstants.kgUnit,
        values: List.generate(221, (i) => i + 30),
        initialIndex: _selectedWeight - 30,
        onChanged: (val) => setState(() => _selectedWeight = val),
      ),
    );
  }
}
