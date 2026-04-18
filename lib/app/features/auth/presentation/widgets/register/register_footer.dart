import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key, required this.onLoginTap});

  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          SignUpConstants.alreadyHave,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: onLoginTap,
          child: const Text(
            SignUpConstants.loginLink,
            style: TextStyle(
              color: AppColors.accentOrange,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.accentOrange,
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterOrDivider extends StatelessWidget {
  const RegisterOrDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.lightDivider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            label,
            style: const TextStyle(color: AppColors.lightDivider),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.lightDivider)),
      ],
    );
  }
}

