import 'package:flutter/material.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import '../cubit/home_navigation_state.dart';

class CustomBottomNavBar extends StatelessWidget {
  final HomeTab selectedTab;
  final ValueChanged<HomeTab> onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(HomeTab.home, Icons.home_outlined, 'Home'),
          _buildNavItem(
            HomeTab.smartCoach,
            Icons.track_changes_outlined,
            'Smart Coach',
          ),
          _buildNavItem(
            HomeTab.workouts,
            Icons.fitness_center_outlined,
            'Workouts',
          ),
          _buildNavItem(HomeTab.profile, Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(HomeTab tab, IconData icon, String label) {
    final isSelected = selectedTab == tab;
    return GestureDetector(
      onTap: () => onTabSelected(tab),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.white70,
            size: 24,
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Text(
              label,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
