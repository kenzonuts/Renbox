import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/constants/categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/category_chip.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/renbok_logo.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/featured_destination_carousel.dart';
import '../widgets/post_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Selamat Pagi';
    if (hour < 15) return 'Selamat Siang';
    if (hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final authState = ref.watch(authProvider);
    final name = authState.profile?.displayName ?? 'Kenzo';

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: homeState.isLoading
            ? const LoadingView(message: 'Memuat petualangan...')
            : RefreshIndicator(
                onRefresh: () => ref.read(homeProvider.notifier).refresh(),
                color: AppColors.forestGreen,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        child: Row(
                          children: [
                            const RenbokLogo(size: 20),
                            const Spacer(),
                            _IconButton(
                              icon: Icons.search_rounded,
                              onTap: () => context.go('/main/explore'),
                            ),
                            const SizedBox(width: 8),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _IconButton(
                                  icon: Icons.notifications_outlined,
                                  onTap: () => context.go('/main/activity'),
                                ),
                                Positioned(
                                  right: 9,
                                  top: 9,
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: AppColors.notificationDot,
                                      shape: BoxShape.circle,
                                      border: Border.fromBorderSide(
                                        BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 20, 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deepForest,
                                  height: 1.25,
                                ),
                                children: [
                                  TextSpan(text: '${_greeting()}, '),
                                  TextSpan(
                                    text: '$name 🌿',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Mau menjelajah alam mana hari ini?',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          clipBehavior: Clip.none,
                          itemCount: natureCategories.length,
                          itemBuilder: (context, index) {
                            final cat = natureCategories[index];
                            final selected =
                                homeState.selectedCategory == cat.apiValue;
                            return CategoryChip(
                              category: cat,
                              selected: selected,
                              onTap: () {
                                ref.read(homeProvider.notifier).selectCategory(
                                      selected ? null : cat.apiValue,
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    if (homeState.featuredList.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: FeaturedDestinationCarousel(
                            locations: homeState.featuredList,
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Petualangan Terbaru',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepForest,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Lihat semua',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppColors.forestGreen,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    size: 18,
                                    color: AppColors.forestGreen,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => PostCard(
                            post: homeState.posts[index],
                            imageCount: index == 0 ? 6 : 1,
                          ),
                          childCount: homeState.posts.length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: AppLayout.bottomContentPadding(context),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.deepForest.withValues(alpha: 0.14),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.deepForest, size: 19),
        ),
      ),
    );
  }
}
