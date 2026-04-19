import 'package:flutter/material.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: iconSize),
      ),
    );
  }
}
