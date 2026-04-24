import 'package:fitness_app/core/constants/auth_constants.dart';
import 'package:fitness_app/core/constants/path_constant.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            PathConstant.appLogoPath,
            width: AuthUiConstants.logoWidth,
            height: AuthUiConstants.logoHeight,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 48),
        Text(
          AuthTextConstants.heyThere,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ),
        Text(
          AuthTextConstants.welcomeBack,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
