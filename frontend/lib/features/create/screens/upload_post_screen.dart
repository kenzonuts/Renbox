import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class UploadPostScreen extends StatelessWidget {
  const UploadPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.cream,
      ),
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24, 24, 24, bottomPadding + 104),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UploadHeader(),
                SizedBox(height: 18),
                _StepIndicator(),
                SizedBox(height: 20),
                _ScreenTitle(),
                SizedBox(height: 20),
                _LocationCard(),
                SizedBox(height: 26),
                _CategorySection(),
                SizedBox(height: 28),
                _SoftDivider(),
                SizedBox(height: 22),
                _PassportSection(),
                SizedBox(height: 18),
                _PassportInfoCard(),
                SizedBox(height: 26),
                _SoftDivider(),
                SizedBox(height: 22),
                _VisibilitySection(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: _BottomButton(
                    label: 'Kembali',
                    icon: Icons.arrow_back_rounded,
                    primary: false,
                    onTap: () => context.pop(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 14,
                  child: _BottomButton(
                    label: 'Lanjut ke Preview',
                    icon: Icons.arrow_forward_rounded,
                    primary: true,
                    trailingIcon: true,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadHeader extends StatelessWidget {
  const _UploadHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: _CircleButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => context.pop(),
            ),
          ),
          Positioned(
            left: 54,
            top: 7,
            right: 84,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Upload Petualangan',
                maxLines: 1,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 22,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 54,
            top: 42,
            right: 4,
            child: Text(
              'Bagikan cerita perjalananmu.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF6B7280),
                fontSize: 14.5,
                height: 1.2,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 2,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Text(
                'Draft',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 15,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.deepForest, size: 28),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator();

  static const _steps = [
    _UploadStep('1', 'Pilih Foto', completed: true),
    _UploadStep('2', 'Ceritakan', completed: true),
    _UploadStep('3', 'Pilih Lokasi', active: true),
    _UploadStep('4', 'Preview'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 70,
            right: 70,
            top: 28,
            child: CustomPaint(
              painter: _DashedLinePainter(activeFraction: 0.67),
              child: SizedBox(height: 1),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _steps
                .map(
                  (step) => SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: step.isGreen
                                ? AppColors.forestGreen
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x10000000),
                                blurRadius: 24,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: step.completed
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Text(
                                  step.number,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: step.active
                                        ? Colors.white
                                        : const Color(0xFF111827),
                                    fontSize: 19,
                                    height: 1,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          step.label,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.plusJakartaSans(
                            color: step.isGreen
                                ? AppColors.deepForest
                                : const Color(0xFF6B7280),
                            fontSize: 13.2,
                            height: 1,
                            fontWeight: step.isGreen
                                ? FontWeight.w800
                                : FontWeight.w700,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ScreenTitle extends StatelessWidget {
  const _ScreenTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Pilih Lokasi & Detail',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 24,
                  height: 1.08,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.location_on_outlined,
              color: Color(0xFFB94A48),
              size: 25,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Beritahu di mana petualanganmu terjadi.',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 15,
            height: 1.35,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.asset(
                'img/create/Upload.png',
                fit: BoxFit.cover,
                alignment: const Alignment(0.42, 0),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gunung Prau',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: 17,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Dieng, Jawa Tengah',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cream.withValues(alpha: 0.74),
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              'Ubah',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.forestGreen,
                fontSize: 13,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection();

  static const _categories = [
    _CategoryItem(Icons.terrain_rounded, 'Gunung', true),
    _CategoryItem(Icons.change_history_rounded, 'Camping', false),
    _CategoryItem(Icons.water_drop_rounded, 'Air Terjun', false),
    _CategoryItem(Icons.wb_sunny_outlined, 'Sunrise', false),
    _CategoryItem(Icons.park_outlined, 'Hutan', false),
    _CategoryItem(Icons.water_rounded, 'Danau', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 18,
            height: 1,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Pilih kategori yang sesuai',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 78,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Container(
                width: 78,
                decoration: BoxDecoration(
                  color:
                      category.selected ? AppColors.forestGreen : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category.icon,
                      size: 28,
                      color: category.selected
                          ? Colors.white
                          : AppColors.forestGreen,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      category.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: category.selected
                            ? Colors.white
                            : AppColors.deepForest,
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PassportSection extends StatelessWidget {
  const _PassportSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambahkan ke Passport Explorer',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 18,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Lokasi ini akan tersimpan dalam koleksi perjalananmu.',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        const _IosToggle(),
      ],
    );
  }
}

class _PassportInfoCard extends StatelessWidget {
  const _PassportInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.fromLTRB(18, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.forestGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.forestGreen,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A1B4332),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.terrain_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(height: 3),
                Text(
                  'PASSPORT',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 5.8,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Koleksi perjalananmu makin lengkap!',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: 13.5,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  'Destinasi ini akan otomatis masuk ke koleksi Passport Explorer setelah diposting.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.3,
                    height: 1.28,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.deepForest,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class _VisibilitySection extends StatelessWidget {
  const _VisibilitySection();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Siapa yang bisa melihat?',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Cerita akan muncul di feed publik.',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              const Text(
                '🌍',
                style: TextStyle(fontSize: 18, height: 1),
              ),
              const SizedBox(width: 8),
              Text(
                'Publik',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.deepForest,
                size: 22,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IosToggle extends StatelessWidget {
  const _IosToggle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 34,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.forestGreen,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x142D6A4F),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.label,
    required this.icon,
    required this.primary,
    required this.onTap,
    this.trailingIcon = false,
  });

  final String label;
  final IconData icon;
  final bool primary;
  final bool trailingIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = primary ? Colors.white : AppColors.deepForest;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primary ? AppColors.forestGreen : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: primary
              ? null
              : Border.all(color: AppColors.deepForest.withValues(alpha: 0.12)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!trailingIcon) ...[
                Icon(icon, color: foreground, size: 25),
                const SizedBox(width: 12),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: foreground,
                  fontSize: 16.5,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              if (trailingIcon) ...[
                const SizedBox(width: 14),
                Icon(icon, color: foreground, size: 27),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SoftDivider extends StatelessWidget {
  const _SoftDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.stone.withValues(alpha: 0.56),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter({required this.activeFraction});

  final double activeFraction;

  @override
  void paint(Canvas canvas, Size size) {
    _drawDashedLine(
      canvas,
      paint: Paint()
        ..color = const Color(0xFFDADADA)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
      maxWidth: size.width,
    );
    _drawDashedLine(
      canvas,
      paint: Paint()
        ..color = AppColors.forestGreen
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
      maxWidth: size.width * activeFraction,
    );
  }

  void _drawDashedLine(
    Canvas canvas, {
    required Paint paint,
    required double maxWidth,
  }) {
    const dashWidth = 7.0;
    const gap = 9.0;
    var x = 0.0;
    while (x < maxWidth) {
      canvas.drawLine(
        Offset(x, 0),
        Offset((x + dashWidth).clamp(0, maxWidth), 0),
        paint,
      );
      x += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UploadStep {
  const _UploadStep(
    this.number,
    this.label, {
    this.completed = false,
    this.active = false,
  });

  final String number;
  final String label;
  final bool completed;
  final bool active;

  bool get isGreen => completed || active;
}

class _CategoryItem {
  const _CategoryItem(this.icon, this.label, this.selected);

  final IconData icon;
  final String label;
  final bool selected;
}
