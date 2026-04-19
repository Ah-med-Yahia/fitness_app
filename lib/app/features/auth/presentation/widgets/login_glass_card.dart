import 'dart:ui';

import 'package:fitness_app/app/core/constants/auth_constants.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginGlassCard extends StatelessWidget {
  const LoginGlassCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AuthUiConstants.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
        child: Container(
          width: double.infinity,
          padding: AuthUiConstants.cardPadding,
          decoration: BoxDecoration(
            color: AppColors.authGlassCard,
            borderRadius: BorderRadius.circular(AuthUiConstants.cardRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
