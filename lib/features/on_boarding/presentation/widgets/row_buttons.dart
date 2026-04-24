import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RowButtons extends StatelessWidget {
  const RowButtons({
    super.key,
    required this.onPressedBack,
    required this.onPressedNext,
    required this.nextText,
  });
  final VoidCallback onPressedBack;
  final VoidCallback onPressedNext;
  final String nextText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: onPressedBack,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(color: AppColors.primary),
          ),
          child: Text(AppTextConstants.back),
        ),
        ElevatedButton(onPressed: onPressedNext, child: Text(nextText)),
      ],
    );
  }
}
