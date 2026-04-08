import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:fitness_app/app/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../view_model/signup/signup_cubit.dart';
import '../view_model/signup/signup_state.dart';
import '../widgets/onboarding_scaffold.dart';
import '../widgets/option_radio_tile.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({super.key});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: UIUtils.showEasyLoading,
          success: () {
            UIUtils.hideEasyLoading();
            context.go(AppRoutesConstants.homeRoute);
          },
          failure: (message) {
            UIUtils.hideEasyLoading();
            UIUtils.showMessage(
              message,
              backGroundColor: AppColors.red,
              textColor: AppColors.white,
            );
          },
        );
      },
      child: OnboardingScaffold(
        stepLabel: SignUpConstants.activityStepLabel,
        stepProgress: 1.0,
        title: SignUpConstants.activityTitle,
        subtitle: '',
        buttonLabel: SignUpConstants.doneLabel,
        onNext: _selectedIndex == null
            ? null
            : () {
                context.read<SignUpCubit>().updateFormData(
                  context.read<SignUpCubit>().formData.copyWith(
                    activityLevel:
                        SignUpConstants.activityApiValues[_selectedIndex!],
                  ),
                );
                context.read<SignUpCubit>().submit();
              },
        cardContent: Column(
          children: List.generate(
            SignUpConstants.activityOptions.length,
            (i) => OptionRadioTile(
              label: SignUpConstants.activityOptions[i],
              isSelected: _selectedIndex == i,
              onTap: () => setState(() => _selectedIndex = i),
            ),
          ),
        ),
      ),
    );
  }
}
