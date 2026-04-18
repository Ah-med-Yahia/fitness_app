import 'package:fitness_app/app/core/constants/signup_constants.dart';
import 'package:fitness_app/app/core/gen/assets.gen.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 46),
        Center(
          child: _Logo(),
        ),
        SizedBox(height: 48),
        Text(
          SignUpConstants.heyThere,
          style: TextStyle(
            fontFamily: 'BaloThambi2',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ),
        Text(
          SignUpConstants.createAccount,
          style: TextStyle(
            fontFamily: 'BaloThambi2',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 48,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Assets.images.logo.image(),
      ),
    );
  }
}

