import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../view_model/signup/signup_cubit.dart';
import '../widgets/onboarding_scaffold.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      stepLabel: SignUpConstants.genderStepLabel,
      stepProgress: 1 / 6,
      title: SignUpConstants.genderTitle,
      subtitle: SignUpConstants.genderSubtitle,
      onNext: _selectedGender == null
          ? null
          : () {
        context.read<SignUpCubit>().updateFormData(
          context.read<SignUpCubit>().formData.copyWith(
            gender: _selectedGender,
          ),
        );
        context.push(AppRoutesConstants.ageRoute);
      },
      cardContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _GenderButton(
            label: SignUpConstants.maleLabel,
            symbol: SignUpConstants.maleSymbol,
            isSelected: _selectedGender == 'male',
            onTap: () => setState(() => _selectedGender = 'male'),
          ),
          const SizedBox(height: 24),
          _GenderButton(
            label: SignUpConstants.femaleLabel,
            symbol: SignUpConstants.femaleSymbol,
            isSelected: _selectedGender == 'female',
            onTap: () => setState(() => _selectedGender = 'female'),
          ),
        ],
      ),
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final String symbol;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.symbol,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 95,
            height: 95,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isSelected ? AppColors.primary : AppColors.transparent,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.white,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                symbol,
                style: const TextStyle(
                  fontSize: 42,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'BaloThambi2',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
