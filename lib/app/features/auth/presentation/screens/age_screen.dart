import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../view_model/signup/signup_cubit.dart';
import '../widgets/onboarding_scaffold.dart';
import '../widgets/wheel_picker_content.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int _selectedAge = 25;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      stepLabel: SignUpConstants.ageStepLabel,
      stepProgress: 2 / 6,
      title: SignUpConstants.ageTitle,
      subtitle: SignUpConstants.onboardingSub,
      onNext: () {
        context.read<SignUpCubit>().updateFormData(
          context.read<SignUpCubit>().formData.copyWith(age: _selectedAge),
        );
        context.push(AppRoutesConstants.weightRoute);
      },
      cardContent: WheelPickerContent(
        unit: SignUpConstants.yearUnit,
        values: List.generate(83, (i) => i + 10),
        initialIndex: _selectedAge - 10,
        onChanged: (val) => setState(() => _selectedAge = val),
      ),
    );
  }
}
