import 'dart:ui';

import 'package:fitness_app/app/core/gen/assets.gen.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Assets.images.authBackground.image(fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
            child: Container(color: AppColors.authOverlay),
          ),
        ),
        child,
      ],
    );
  }
}
