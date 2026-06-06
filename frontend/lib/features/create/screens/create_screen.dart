import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      _CreateOption(
        icon: Icons.photo_camera_rounded,
        title: 'Upload Foto',
        subtitle: 'Bagikan momen petualanganmu',
        color: AppColors.forestGreen,
        onTap: () => context.push('/upload-post'),
      ),
      _CreateOption(
        icon: Icons.location_on_rounded,
        title: 'Check-In Lokasi',
        subtitle: 'Tandai lokasi yang dikunjungi',
        color: AppColors.skyBlue,
        onTap: () {},
      ),
      _CreateOption(
        icon: Icons.menu_book_rounded,
        title: 'Adventure Log',
        subtitle: 'Catat perjalanan lengkap',
        color: AppColors.earthBrown,
        onTap: () {},
      ),
      _CreateOption(
        icon: Icons.collections_rounded,
        title: 'Album Perjalanan',
        subtitle: 'Kumpulkan foto dalam album',
        color: AppColors.deepForest,
        onTap: () {},
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buat Konten',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepForest,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilih jenis konten yang ingin dibagikan',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              ...options.map(
                (o) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: o,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateOption extends StatelessWidget {
  const _CreateOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: AppColors.cardShadow, blurRadius: 12),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
