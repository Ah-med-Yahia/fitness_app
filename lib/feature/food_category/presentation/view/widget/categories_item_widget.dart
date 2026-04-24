import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';

class CategoriesItemWidget extends StatelessWidget {
  const CategoriesItemWidget({
    super.key,
    required this.itemName,
    this.isSelected = false,
  });

  final String itemName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? AppColors.primary : null,
      ),
      child: Column(
        children: [
          Text(
            itemName,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
