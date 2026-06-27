import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  static const _storyText = 'Sunrise di Gunung Prau benar-benar luar biasa.\n\n'
      'Udara dingin, langit jernih, dan pemandangan 360° membuat semua rasa lelah selama pendakian langsung terbayar.\n\n'
      'Kalau ada satu tempat yang ingin aku datangi lagi, mungkin ini jawabannya.';

  final _picker = ImagePicker();
  final _storyController = TextEditingController(text: _storyText);
  XFile? _image;

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      imageQuality: 88,
    );
    if (image != null && mounted) {
      setState(() => _image = image);
    }
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _UploadHeader(),
                const SizedBox(height: 22),
                const _StepIndicator(),
                const SizedBox(height: 34),
                const _StorySectionTitle(),
                const SizedBox(height: 20),
                _CompactPhotoPreview(image: _image, onEdit: _pickImage),
                const SizedBox(height: 18),
                _StoryEditor(controller: _storyController),
                const SizedBox(height: 18),
                const _TipsCard(),
                const SizedBox(height: 24),
                const _QuickTags(),
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
                  flex: 13,
                  child: _BottomButton(
                    label: 'Lanjut',
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
      height: 94,
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
            top: 8,
            right: 0,
            child: Text(
              'Upload Petualangan',
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 22,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            left: 54,
            top: 48,
            right: 4,
            child: Text(
              'Bagikan cerita dari perjalananmu\ndan inspirasi untuk explorer lainnya.',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF6B7280),
                fontSize: 14.5,
                height: 1.42,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 4,
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
    _UploadStep('2', 'Ceritakan', active: true),
    _UploadStep('3', 'Pilih Lokasi'),
    _UploadStep('4', 'Selesai'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 70,
            right: 70,
            top: 28,
            child: CustomPaint(
              painter: _DashedLinePainter(activeFraction: 0.34),
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
                            fontSize: 13.5,
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

class _StorySectionTitle extends StatelessWidget {
  const _StorySectionTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Ceritakan pengalamanmu 🌿',
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 30,
                height: 1.08,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Apa yang kamu rasakan di tempat ini?',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 16,
            height: 1.35,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class _CompactPhotoPreview extends StatelessWidget {
  const _CompactPhotoPreview({required this.image, required this.onEdit});

  final XFile? image;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 90,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              image == null
                  ? Image.asset(
                      'img/create/Upload.png',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.42, 0),
                    )
                  : Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    ),
              Positioned(
                right: 8,
                bottom: 8,
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      'Edit Foto',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.deepForest,
                        fontSize: 10.5,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sunrise di Gunung Prau',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 17,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                'Foto utama petualanganmu',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 13,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StoryEditor extends StatelessWidget {
  const _StoryEditor({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              cursorColor: AppColors.deepForest,
              decoration: InputDecoration(
                hintText: 'Apa cerita terbaik dari perjalananmu?',
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 15.5,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF243044),
                fontSize: 15.5,
                height: 1.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '128 / 1000',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.forestGreen,
                fontSize: 12.5,
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

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.forestGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡',
            style: TextStyle(fontSize: 22, height: 1.05),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 13,
                  height: 1.45,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
                children: [
                  TextSpan(
                    text: 'Tips: ',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.deepForest,
                      fontSize: 13,
                      height: 1.45,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'Cerita yang jujur dan detail akan membantu explorer lain mengetahui pengalamanmu.',
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

class _QuickTags extends StatelessWidget {
  const _QuickTags();

  static const _tags = [
    '☀️ Sunrise',
    '🌄 Sunset',
    '🥾 Hiking',
    '🏕 Camping',
    '🌿 Hidden Gem',
    '✨ View Point',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tambahkan suasana (opsional)',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 15,
            height: 1,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            itemCount: _tags.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final selected = index == 0;
              return Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppColors.forestGreen : Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color:
                        selected ? AppColors.forestGreen : Colors.transparent,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  _tags[index],
                  style: GoogleFonts.plusJakartaSans(
                    color: selected ? Colors.white : AppColors.deepForest,
                    fontSize: 13,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
                fontSize: 17,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            if (trailingIcon) ...[
              const SizedBox(width: 16),
              Icon(icon, color: foreground, size: 29),
            ],
          ],
        ),
      ),
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
      size,
      paint: Paint()
        ..color = const Color(0xFFDADADA)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
      maxWidth: size.width,
    );
    _drawDashedLine(
      canvas,
      size,
      paint: Paint()
        ..color = AppColors.forestGreen
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
      maxWidth: size.width * activeFraction,
    );
  }

  void _drawDashedLine(
    Canvas canvas,
    Size size, {
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
