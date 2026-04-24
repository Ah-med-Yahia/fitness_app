import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        border: Border.all(color: AppColors.gray, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      width: 130,
      height: 150,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          // Text(
          //   AppLocale(context).loading,
          //   style: TextStyle(
          //     color: AppColors.gray,
          //     fontSize: 14,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
        ],
      ),
    ),
  );
}
