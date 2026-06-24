import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_top_header.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(18, 16, 18, 132),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CreateHeader(),
              SizedBox(height: 16),
              _HeroTitle(),
              SizedBox(height: 4),
              _UploadAdventureCard(),
              SizedBox(height: 24),
              _ActionGrid(),
              SizedBox(height: 24),
              _LevelProgressCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateHeader extends StatelessWidget {
  const _CreateHeader();

  @override
  Widget build(BuildContext context) {
    return AppTopHeader(
      horizontalPadding: 0,
      onSearchTap: () => context.go('/main/explore'),
      onNotificationTap: () => context.go('/main/activity'),
      onProfileTap: () => context.go('/main/profile'),
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -38,
            top: -18,
            width: 292,
            height: 178,
            child: Image.asset(
              'img/create/adventure.png',
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: 188,
            child: Text(
              'Create\nAdventure',
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 32,
                height: 0.98,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 80,
            width: 168,
            child: Text(
              'Bagikan pengalaman\nalam terbaikmu.',
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF4B5563),
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadAdventureCard extends StatelessWidget {
  const _UploadAdventureCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/upload-post'),
      child: Container(
        height: 190,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'img/create/Upload.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.deepForest.withValues(alpha: 0.9),
                    AppColors.deepForest.withValues(alpha: 0.58),
                    AppColors.deepForest.withValues(alpha: 0.04),
                  ],
                  stops: const [0, 0.42, 1],
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 16,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFA7E08A),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.photo_camera_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 18,
              bottom: 88,
              child: Text(
                'Upload Petualangan',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 128,
              bottom: 58,
              child: Text(
                'Bagikan foto, cerita, dan\nmomen terbaikmu.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 11,
                  height: 1.24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 22,
              child: Container(
                height: 32,
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mulai Upload',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.deepForest,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.deepForest,
                      size: 18,
                    ),
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

class _ActionGrid extends StatelessWidget {
  const _ActionGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _ActionCard(
          title: 'Check-In Lokasi',
          description: 'Tandai tempat yang pernah kamu kunjungi.',
          icon: Icons.location_on_rounded,
          iconColor: AppColors.deepForest,
          backgroundColor: Color(0xFFEFF8ED),
          artColor: Color(0xFF74AF55),
          arrowColor: Color(0xFFDDEFD8),
          backgroundAsset: 'img/create/lokasi.png',
        ),
        _ActionCard(
          title: 'Panduan Pendakian',
          description: 'Cari jalur, cuaca, dan informasi pendakian.',
          icon: Icons.hiking_rounded,
          iconColor: Color(0xFF7A4F2E),
          backgroundColor: Color(0xFFFFF4E8),
          artColor: Color(0xFFD4B28A),
          arrowColor: Color(0xFFF4E1C9),
          backgroundAsset: 'img/create/panduan.png',
        ),
        _ActionCard(
          title: 'Adventure Log',
          badge: 'Coming Soon',
          description: 'Catat setiap langkah petualanganmu.',
          icon: Icons.edit_note_rounded,
          iconColor: Color(0xFF5F6368),
          backgroundColor: Color(0xFFF2F3F5),
          artColor: Color(0xFFD9DDE1),
          disabled: true,
        ),
        _ActionCard(
          title: 'Travel Album',
          badge: 'Coming Soon',
          description: 'Kumpulkan momen petualangan dalam satu album.',
          icon: Icons.collections_rounded,
          iconColor: Color(0xFF2375A7),
          backgroundColor: Color(0xFFEFF7FB),
          artColor: Color(0xFFBBD9E8),
          disabled: true,
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.artColor,
    this.arrowColor = const Color(0xFFF1F3F4),
    this.backgroundAsset,
    this.badge,
    this.disabled = false,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color artColor;
  final Color arrowColor;
  final String? backgroundAsset;
  final String? badge;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.9 : 1,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (backgroundAsset != null) ...[
              Positioned.fill(
                child: Image.asset(
                  backgroundAsset!,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.76),
                        Colors.white.withValues(alpha: 0.5),
                        Colors.white.withValues(alpha: 0.08),
                      ],
                      stops: const [0, 0.48, 1],
                    ),
                  ),
                ),
              ),
            ] else
              Positioned.fill(
                child: CustomPaint(
                  painter: _CardLandscapePainter(
                    color: artColor,
                    disabled: disabled,
                  ),
                ),
              ),
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.48),
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
            ),
            Positioned(
              left: 64,
              right: 12,
              top: 20,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color:
                      disabled ? const Color(0xFF111827) : AppColors.deepForest,
                  fontSize: 12.8,
                  height: 1.08,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
            if (badge != null)
              Positioned(
                left: 64,
                right: 12,
                top: 54,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      badge!,
                      maxLines: 1,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF4B5563),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 64,
              right: 67,
              top: badge == null ? 66 : 82,
              child: Text(
                description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF374151),
                  fontSize: 10.2,
                  height: 1.22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              right: 14,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: disabled
                        ? Colors.white.withValues(alpha: 0.82)
                        : arrowColor.withValues(alpha: 0.94),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.07),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    disabled
                        ? Icons.lock_outline_rounded
                        : Icons.chevron_right_rounded,
                    color: disabled
                        ? const Color(0xFF4B5563)
                        : AppColors.deepForest,
                    size: disabled ? 18 : 23,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelProgressCard extends StatelessWidget {
  const _LevelProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const _ExplorerBadge(),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 80,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 1,
                    child: Text(
                      'Level 7 Explorer',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.deepForest,
                        fontSize: 18,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 26,
                    child: Text(
                      '780 / 1.000 XP',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF374151),
                        fontSize: 13,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 46,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                      child: LinearProgressIndicator(
                        value: 0.78,
                        minHeight: 8,
                        backgroundColor: Color(0xFFE5E7EB),
                        color: AppColors.forestGreen,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 64,
                    child: Text(
                      '2 aktivitas lagi menuju level berikutnya',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.forestGreen,
                        fontSize: 11.5,
                        height: 1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.deepForest,
            size: 32,
          ),
        ],
      ),
    );
  }
}

class _ExplorerBadge extends StatelessWidget {
  const _ExplorerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Color(0xFF2C7A3F),
            AppColors.deepForest,
          ],
        ),
        border: Border.all(color: const Color(0xFF0F2E23), width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepForest.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (final item in const [
            _BadgeStar(0, -23),
            _BadgeStar(16, -17),
            _BadgeStar(22, 4),
            _BadgeStar(13, 21),
            _BadgeStar(-14, 20),
            _BadgeStar(-23, 2),
            _BadgeStar(-15, -17),
          ])
            Positioned(
              left: 30 + item.dx,
              top: 30 + item.dy,
              child: const Icon(
                Icons.star_rounded,
                color: Color(0xFFE4D358),
                size: 7,
              ),
            ),
          const Icon(
            Icons.landscape_rounded,
            color: Color(0xFFB5D94A),
            size: 30,
          ),
        ],
      ),
    );
  }
}

class _BadgeStar {
  const _BadgeStar(this.dx, this.dy);

  final double dx;
  final double dy;
}

class _CardLandscapePainter extends CustomPainter {
  const _CardLandscapePainter({
    required this.color,
    required this.disabled,
  });

  final Color color;
  final bool disabled;

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..color = color.withValues(alpha: disabled ? 0.36 : 0.78);
    final pale = Paint()
      ..color = Colors.white.withValues(alpha: disabled ? 0.25 : 0.62);
    final dark = Paint()
      ..color = color.withValues(alpha: disabled ? 0.18 : 0.95);

    final y = size.height;
    final back = Path()
      ..moveTo(0, y)
      ..lineTo(size.width * 0.36, size.height * 0.62)
      ..lineTo(size.width * 0.53, size.height * 0.78)
      ..lineTo(size.width * 0.72, size.height * 0.56)
      ..lineTo(size.width, size.height * 0.88)
      ..lineTo(size.width, y)
      ..close();
    canvas.drawPath(
        back, Paint()..color = color.withValues(alpha: disabled ? 0.14 : 0.3));

    final front = Path()
      ..moveTo(0, y)
      ..lineTo(size.width * 0.45, size.height * 0.72)
      ..lineTo(size.width * 0.68, size.height * 0.92)
      ..lineTo(size.width * 0.84, size.height * 0.72)
      ..lineTo(size.width, size.height * 0.95)
      ..lineTo(size.width, y)
      ..close();
    canvas.drawPath(front, base);

    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.05, size.height * 0.65, 54, 17),
      pale,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.66, 64, 18),
      pale,
    );

    if (!disabled) {
      for (var i = 0; i < 8; i++) {
        final x = size.width * (0.18 + i * 0.075);
        _drawMiniPine(
            canvas, Offset(x, size.height - 2), 20 + (i % 3) * 6, dark);
      }
    } else {
      canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.08, size.height * 0.74, size.width * 0.62, 26),
        Paint()..color = Colors.white.withValues(alpha: 0.12),
      );
    }
  }

  void _drawMiniPine(Canvas canvas, Offset base, double height, Paint paint) {
    final path = Path()
      ..moveTo(base.dx, base.dy - height)
      ..lineTo(base.dx - height * 0.24, base.dy)
      ..lineTo(base.dx + height * 0.24, base.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CardLandscapePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.disabled != disabled;
  }
}
