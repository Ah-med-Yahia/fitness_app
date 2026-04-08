import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../view_model/signup/signup_cubit.dart';
import '../widgets/onboarding_scaffold.dart';
import '../widgets/wheel_picker_content.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  int _selectedHeight = 170;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      stepLabel: SignUpConstants.heightStepLabel,
      stepProgress: 4 / 6,
      title: SignUpConstants.heightTitle,
      subtitle: SignUpConstants.onboardingSub,
      onNext: () {
        context.read<SignUpCubit>().updateFormData(
          context.read<SignUpCubit>().formData.copyWith(
            height: _selectedHeight,
          ),
        );
        context.push(AppRoutesConstants.goalRoute);
      },
      cardContent: WheelPickerContent(
        unit: SignUpConstants.cmUnit,
        values: List.generate(171, (i) => i + 100),
        initialIndex: _selectedHeight - 100,
        onChanged: (val) => setState(() => _selectedHeight = val),
      ),
    );
  }
}
