import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

import '../../notifications/screens/notification_center_screen.dart';
import '../../profile/screens/user_profile_screen.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Brand Icon & Title
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.recycling_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'WasteHub',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(width: 8),

        // Spot Pasar Indicator Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.spotBadgeBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.spotBadgeText,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'SPOT PASAR',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.spotBadgeText,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // Notification Bell Icon with Badge
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationCenterScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.notificationAlert,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // Profile Avatar (PT Industri)
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UserProfileScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.spotBadgeBg,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF86EFAC), width: 1.2),
            ),
            child: const Center(
              child: Text(
                'PT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF166534),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
