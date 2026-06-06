import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/dummy_data.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authProvider).profile ?? DummyData.demoProfile;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: profile.avatarUrl != null
                            ? CachedNetworkImageProvider(profile.avatarUrl!)
                            : null,
                        backgroundColor: AppColors.stone,
                        child: profile.avatarUrl == null
                            ? Text(
                                profile.displayName[0].toUpperCase(),
                                style: const TextStyle(fontSize: 32),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.displayName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        '@${profile.username}',
                        style: const TextStyle(color: AppColors.textMuted),
                      ),
                      if (profile.bio != null) ...[
                        const SizedBox(height: 8),
                        Text(profile.bio!, textAlign: TextAlign.center),
                      ],
                      if (profile.city != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          '📍 ${profile.city}',
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _StatItem(count: '24', label: 'Posts'),
                          _StatItem(count: '12', label: 'Check-ins'),
                          _StatItem(count: '8', label: 'Wishlist'),
                          _StatItem(count: '3', label: 'Badges'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (AppConstants.requireAuth)
                        OutlinedButton(
                          onPressed: () async {
                            await ref.read(authProvider.notifier).logout();
                            if (context.mounted) context.go('/login');
                          },
                          child: const Text('Keluar'),
                        ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    labelColor: AppColors.deepForest,
                    unselectedLabelColor: AppColors.textMuted,
                    indicatorColor: AppColors.forestGreen,
                    tabs: const [
                      Tab(text: 'Posts'),
                      Tab(text: 'Albums'),
                      Tab(text: 'Check-In'),
                      Tab(text: 'Badges'),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                _GridPlaceholder(icon: Icons.grid_on),
                _GridPlaceholder(icon: Icons.collections),
                _GridPlaceholder(icon: Icons.location_on),
                _BadgesTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.count, required this.label});

  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(color: AppColors.cream, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _GridPlaceholder extends StatelessWidget {
  const _GridPlaceholder({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 9,
      itemBuilder: (_, __) => Container(
        color: AppColors.stone,
        child: Icon(icon, color: AppColors.textMuted),
      ),
    );
  }
}

class _BadgesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _BadgeCard(name: 'Pendaki Pertama', icon: Icons.landscape),
        _BadgeCard(name: 'Penjelajah Alam', icon: Icons.explore),
        _BadgeCard(name: 'Storyteller', icon: Icons.camera_alt, locked: true),
      ],
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.name,
    required this.icon,
    this.locked = false,
  });

  final String name;
  final IconData icon;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: locked
              ? AppColors.stone
              : AppColors.forestGreen.withValues(alpha: 0.2),
          child: Icon(
            icon,
            color: locked ? AppColors.textMuted : AppColors.forestGreen,
          ),
        ),
        title: Text(name),
        subtitle: Text(locked ? 'Belum diperoleh' : 'Diperoleh'),
        trailing: locked
            ? const Icon(Icons.lock_outline, color: AppColors.textMuted)
            : const Icon(Icons.check_circle, color: AppColors.forestGreen),
      ),
    );
  }
}
