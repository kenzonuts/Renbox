import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/dummy_data.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../models/location_model.dart';
import '../../../services/api_service.dart';

class LocationDetailScreen extends ConsumerWidget {
  const LocationDetailScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<LocationModel?>(
      future: ref.read(apiServiceProvider).getLocationBySlug(slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: LoadingView());
        }

        final location = snapshot.data ??
            DummyData.popularLocations.firstWhere(
              (l) => l.slug == slug,
              orElse: () => DummyData.featuredLocation,
            );

        return Scaffold(
          backgroundColor: AppColors.cream,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: location.coverImageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: location.coverImageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(color: AppColors.stone),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.forestGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              location.categoryLabel,
                              style: const TextStyle(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (location.ratingAverage != null)
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  location.ratingAverage!.toStringAsFixed(1),
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  ' (${location.reviewsCount ?? 0})',
                                  style: const TextStyle(color: AppColors.textMuted),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        location.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location.locationLine,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _StatChip(
                            icon: Icons.terrain,
                            label: location.difficultyLabel,
                          ),
                          const SizedBox(width: 12),
                          if (location.altitude != null)
                            _StatChip(
                              icon: Icons.height,
                              label: '${location.altitude} mdpl',
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border),
                              label: const Text('Wishlist'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.deepForest,
                                side: const BorderSide(color: AppColors.forestGreen),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text('Check-in'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Deskripsi',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        location.description ??
                            'Destinasi alam populer di Indonesia. Segera hadir detail lengkap.',
                        style: const TextStyle(height: 1.6, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Foto Komunitas',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, i) => Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: AppColors.stone,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.image, color: AppColors.textMuted),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Ulasan',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 12),
                      const Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person)),
                          title: Text('Petualang RENBOK'),
                          subtitle: Text('Pengalaman luar biasa! Pemandangan menakjubkan.'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Text(' 5'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.stone),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.forestGreen),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
