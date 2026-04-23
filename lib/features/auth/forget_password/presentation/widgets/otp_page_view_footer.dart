import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPageViewFooter extends StatelessWidget {
  const OtpPageViewFooter({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          AppTextConstants.didntRecieveVerificationCode,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            context.read<ForgetPasswordCubit>().doIntent(
              ResendOtpCodeIntent(email: email),
            );
          },
          child: Text(
            AppTextConstants.resendCode,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
