import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class WasteHubBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const WasteHubBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                selectedIcon: Icons.storefront_rounded,
                unselectedIcon: Icons.storefront_outlined,
                label: 'Pasar',
              ),
              _buildNavItem(
                index: 1,
                selectedIcon: Icons.article_rounded,
                unselectedIcon: Icons.article_outlined,
                label: 'Kontrak',
              ),
              _buildNavItem(
                index: 2,
                selectedIcon: Icons.chat_bubble_rounded,
                unselectedIcon: Icons.chat_bubble_outline_rounded,
                label: 'Inbox',
              ),
              _buildNavItem(
                index: 3,
                selectedIcon: Icons.apartment_rounded,
                unselectedIcon: Icons.apartment_outlined,
                label: 'Bisnis',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    IconData? icon,
    IconData? selectedIcon,
    IconData? unselectedIcon,
    required String label,
  }) {
    final isSelected = index == currentIndex;
    final color = isSelected ? AppColors.primary : AppColors.textMuted;
    final activeIcon = isSelected
        ? (selectedIcon ?? icon ?? Icons.circle)
        : (unselectedIcon ?? icon ?? Icons.circle_outlined);

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activeIcon,
              size: 22,
              color: color,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: color,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
