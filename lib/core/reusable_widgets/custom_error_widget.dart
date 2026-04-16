import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.red),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage,style: TextStyle(
            color: AppColors.black
          ),),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('retry'),
          ),
        ],
      ),
    );
  }
}
