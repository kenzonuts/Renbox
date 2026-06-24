import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_top_header.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../models/location_model.dart';
import '../../../models/post_model.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/home_provider.dart';

const _green = Color(0xFF124D3B);
const _ink = Color(0xFF0A251D);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final profile = ref.watch(authProvider).profile;

    if (state.isLoading) {
      return const Scaffold(
        body: LoadingView(message: 'Memuat petualangan...'),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF7),
      body: RefreshIndicator(
        color: _green,
        onRefresh: () => ref.read(homeProvider.notifier).refresh(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _ImmersiveHeroHeader(
                featured: state.featured,
                avatarUrl: profile?.avatarUrl,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                transform: Matrix4.translationValues(0, -16, 0),
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFCFAF7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A1B4332),
                      blurRadius: 30,
                      offset: Offset(0, -8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const _PassportCard(),
                    const SizedBox(height: 22),
                    const _SectionTitle(
                      title: 'AKSES CEPAT',
                      action: 'Semua Fitur',
                    ),
                    const SizedBox(height: 10),
                    const _QuickAccess(),
                    const SizedBox(height: 24),
                    const _SectionTitle(title: 'REKOMENDASI AKHIR PEKAN'),
                    const SizedBox(height: 10),
                    _Recommendations(locations: state.featuredList),
                    const SizedBox(height: 24),
                    _SectionTitle(
                      title: 'CERITA TERBARU DARI KOMUNITAS',
                      onTap: () => context.push('/community-stories'),
                    ),
                    const SizedBox(height: 10),
                    _CommunityPosts(posts: state.posts),
                    SizedBox(height: AppLayout.bottomContentPadding(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImmersiveHeroHeader extends StatelessWidget {
  const _ImmersiveHeroHeader({
    required this.featured,
    this.avatarUrl,
  });

  final LocationModel? featured;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    const heroHeight = 240.0;
    final destName = featured?.name ?? 'Gunung Prau';
    final destLocation = featured?.locationLine.isNotEmpty == true
        ? featured!.locationLine
        : 'Dieng, Jawa Tengah';
    final slug = featured?.slug ?? 'gunung-prau';

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'img/home/home.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroHeight * 0.38,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.72),
                    Colors.white.withValues(alpha: 0.28),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: heroHeight * 0.45,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.18),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTopHeader(
                    variant: AppTopHeaderVariant.overlay,
                    horizontalPadding: 18,
                    avatarUrl: avatarUrl,
                    onSearchTap: () => context.go('/main/explore'),
                    onNotificationTap: () => context.go('/main/activity'),
                    onProfileTap: () => context.go('/main/profile'),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () => context.push('/location/$slug'),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x240A1E16),
                              blurRadius: 24,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0x940A1E16),
                                    Color(0x330A1E16),
                                    Color(0x000A1E16),
                                  ],
                                  stops: [0.0, 0.38, 0.72],
                                ),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.explore_outlined,
                                          size: 11,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'EKSPEDISI MINGGU INI',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    destName,
                                    style: GoogleFonts.dmSerifDisplay(
                                      fontSize: 18,
                                      color: Colors.white,
                                      height: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 13,
                                        color:
                                            Colors.white.withValues(alpha: 0.9),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        destLocation,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                              .withValues(alpha: 0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: _HeroInfoItem(
                                          icon: Icons.wb_sunny_outlined,
                                          label: 'Cuaca',
                                          value: 'Cerah',
                                        ),
                                      ),
                                      Expanded(
                                        child: _HeroInfoItem(
                                          icon: Icons.shield_outlined,
                                          label: 'Status Jalur',
                                          value: 'Aman',
                                          valueColor: Color(0xFF74C69D),
                                        ),
                                      ),
                                      Expanded(
                                        child: _HeroInfoItem(
                                          icon: Icons.groups_outlined,
                                          label: 'Pendaki Minggu Ini',
                                          value: '128 pendaki',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 32,
                                        child: Material(
                                          color: const Color(0xFF2D6A4F),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: InkWell(
                                            onTap: () =>
                                                context.push('/location/$slug'),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Lihat Panduan',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: Colors.white,
                                                    size: 13,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.12),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.bookmark_border_rounded,
                                          color: _ink,
                                          size: 19,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroInfoItem extends StatelessWidget {
  const _HeroInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.7)),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 8,
                  color: Colors.white.withValues(alpha: 0.65),
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: valueColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}

class _PassportCard extends StatelessWidget {
  const _PassportCard();

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => context.push('/adventure-passport'),
          child: Container(
            height: 140,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              image: const DecorationImage(
                image: AssetImage('img/home/cardpetualangan.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xF2FFFFFF),
                          Color(0xCFFFFFFF),
                          Color(0x00FFFFFF),
                        ],
                        stops: [0, 0.42, 0.82],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '♟  PASSPORT EXPLORER',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              color: _green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Lihat Detail  →',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              color: _green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Koleksi Petualanganmu',
                        style: GoogleFonts.dmSerifDisplay(
                            fontSize: 18, color: _green),
                      ),
                      Text(
                        'Terus jelajahi, kumpulkan lebih banyak momen!',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 8.5,
                          color: Colors.black54,
                        ),
                      ),
                      const Spacer(),
                      const Row(
                        children: [
                          _PassportStat(
                              icon: '⛰', count: '12', label: 'Gunung'),
                          _PassportStat(
                              icon: '♨', count: '8', label: 'Air Terjun'),
                          _PassportStat(
                              icon: '⛺', count: '15', label: 'Camping'),
                          _PassportStat(
                              icon: '●', count: '24', label: 'Check-in'),
                          Spacer(),
                          _ProgressRing(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _QuickAccess extends StatelessWidget {
  const _QuickAccess();

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(
            child: _QuickCard(
              icon: '🥾',
              title: 'Panduan\nPendakian',
              detail: 'Rute, tips, & logistik',
              color: Color(0xFFF0F3E9),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _QuickCard(
              icon: '📍',
              title: 'Destinasi',
              detail: 'Temukan tempat terbaik',
              color: Color(0xFFF8F0E2),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _QuickCard(
              icon: '⛺',
              title: 'Camping\nGround',
              detail: 'Rekomendasi camping terbaik',
              color: Color(0xFFEDF1E8),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _QuickCard(
              icon: '🌤️',
              title: 'Cuaca\nGunung',
              detail: 'Cek prakiraan cuaca',
              color: Color(0xFFE7F2FA),
            ),
          ),
        ],
      );
}

class _Recommendations extends StatelessWidget {
  const _Recommendations({required this.locations});

  final List<LocationModel> locations;

  @override
  Widget build(BuildContext context) {
    final cardWidth = (MediaQuery.sizeOf(context).width - 40).clamp(
      320.0,
      420.0,
    );
    final imageWidth = cardWidth * 0.44;

    return SizedBox(
      height: 142,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: locations.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final l = locations[i];
          final isEasy = l.difficulty == 'easy' || l.difficulty == null;
          return GestureDetector(
            onTap: () => context.push('/weekend-recommendation/gunung-prau'),
            child: Container(
              width: cardWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color(0x15000000), blurRadius: 12),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(20),
                    ),
                    child: l.coverImageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: l.coverImageUrl!,
                            width: imageWidth,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: imageWidth,
                            color: AppColors.stone,
                            child: const Icon(Icons.landscape, color: _green),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 10, 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.name,
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 19,
                              color: _ink,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '● ${l.locationLine}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _TagBadge(
                                label: isEasy
                                    ? 'Beginner Friendly'
                                    : l.difficultyLabel,
                                isGreen: isEasy,
                              ),
                              const SizedBox(width: 6),
                              if (l.duration != null)
                                _TagBadge(
                                  label: l.duration!,
                                  isGreen: false,
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Text(
                              l.description?.isNotEmpty == true
                                  ? l.description!
                                  : 'Destinasi dengan pemandangan indah, cocok untuk akhir pekan.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 8.5,
                                color: Colors.black54,
                                height: 1.35,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.wb_cloudy_outlined,
                                size: 13,
                                color: Colors.black.withValues(alpha: 0.45),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '18°C – 26°C',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9,
                                  color: Colors.black54,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: _green,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  'Lihat Panduan',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.label, required this.isGreen});

  final String label;
  final bool isGreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: isGreen
            ? _green.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: isGreen ? _green : Colors.black54,
        ),
      ),
    );
  }
}

class _CommunityPosts extends StatelessWidget {
  const _CommunityPosts({required this.posts});

  final List<PostModel> posts;

  String _timeAgo(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 320,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: posts.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final p = posts[i];
            final username = p.profile?.username ?? 'explorer';
            return Container(
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Color(0x11000000), blurRadius: 12),
                ],
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () =>
                      context.push('/community-story/sunrise-gunung-prau'),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundImage: p.profile?.avatarUrl == null
                                  ? null
                                  : NetworkImage(p.profile!.avatarUrl!),
                              child: p.profile?.avatarUrl == null
                                  ? const Icon(Icons.person, size: 18)
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '@$username  ✓',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    '● ${p.location?.name ?? ''}  ·  ${_timeAgo(p.createdAt)}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 9,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.more_horiz, size: 18),
                          ],
                        ),
                        const SizedBox(height: 9),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: p.imageUrl,
                            height: 155,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.caption ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            height: 1.4,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.favorite_border, size: 18),
                            Text(
                              ' ${_formatCount(p.likesCount)}',
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.chat_bubble_outline, size: 17),
                            Text(
                              ' ${p.commentsCount}',
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.share_outlined, size: 17),
                            Text(
                              ' ${p.sharesCount}',
                              style: const TextStyle(fontSize: 10),
                            ),
                            const Spacer(),
                            const Icon(Icons.bookmark_border, size: 18),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    this.action = 'Lihat Semua',
    this.onTap,
  });

  final String title;
  final String action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _green,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Text(
                '$action  ›',
                style: GoogleFonts.plusJakartaSans(fontSize: 10, color: _ink),
              ),
            ),
          ),
        ],
      );
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.icon,
    required this.title,
    required this.detail,
    required this.color,
  });

  final String icon;
  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        height: 108,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 9),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(icon, style: const TextStyle(fontSize: 23)),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              detail,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(fontSize: 8, height: 1.25),
            ),
          ],
        ),
      );
}

class _PassportStat extends StatelessWidget {
  const _PassportStat({
    required this.icon,
    required this.count,
    required this.label,
  });

  final String icon;
  final String count;
  final String label;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 45,
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 13, color: _green)),
            Text(
              count,
              style: GoogleFonts.dmSerifDisplay(fontSize: 16, color: _ink),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 6.5, color: Colors.black54),
            ),
          ],
        ),
      );
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 58,
        height: 58,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 58,
              height: 58,
              child: CircularProgressIndicator(
                value: 0.68,
                strokeWidth: 5,
                backgroundColor: _green.withValues(alpha: 0.15),
                color: _green,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '68%',
                  style:
                      GoogleFonts.dmSerifDisplay(fontSize: 16, color: _green),
                ),
                const Text('Progress', style: TextStyle(fontSize: 6)),
              ],
            ),
          ],
        ),
      );
}
