import 'package:flutter/material.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      _NotificationItem(
        icon: Icons.favorite,
        color: AppColors.error,
        title: 'sarah_hikes menyukai postinganmu',
        time: '2 jam lalu',
      ),
      _NotificationItem(
        icon: Icons.chat_bubble,
        color: AppColors.skyBlue,
        title: 'budi_explorer mengomentari postinganmu',
        time: '5 jam lalu',
      ),
      _NotificationItem(
        icon: Icons.person_add,
        color: AppColors.forestGreen,
        title: 'nature_id mulai mengikuti kamu',
        time: '1 hari lalu',
      ),
      _NotificationItem(
        icon: Icons.military_tech,
        color: Colors.amber,
        title: 'Kamu mendapat badge Pendaki Pertama!',
        time: '2 hari lalu',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aktivitas',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepForest,
                        ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Tandai dibaca')),
                ],
              ),
            ),
            Expanded(
              child: notifications.isEmpty
                  ? const EmptyState(
                      icon: Icons.notifications_none,
                      title: 'Belum ada notifikasi',
                      subtitle: 'Aktivitas like, comment, dan follow akan muncul di sini',
                    )
                  : ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        AppLayout.bottomContentPadding(context),
                      ),
                      itemCount: notifications.length,
                      itemBuilder: (_, i) => notifications[i],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.time,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
