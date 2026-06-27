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
  final _picker = ImagePicker();
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
            padding: EdgeInsets.fromLTRB(24, 24, 24, bottomPadding + 112),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _UploadHeader(),
                const SizedBox(height: 20),
                const _StepIndicator(),
                const SizedBox(height: 30),
                const _PhotoSectionTitle(),
                const SizedBox(height: 22),
                _PhotoPreviewCard(image: _image),
                const SizedBox(height: 18),
                const _PhotoDots(),
                const SizedBox(height: 28),
                _ActionGrid(onPickImage: _pickImage),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: _ContinueButton(onTap: () {}),
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
            left: 66,
            top: 8,
            right: 0,
            child: Text(
              'Upload Petualangan',
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 27,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            left: 66,
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
              padding: const EdgeInsets.symmetric(horizontal: 22),
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
    _UploadStep('1', 'Pilih Foto', true),
    _UploadStep('2', 'Ceritakan', false),
    _UploadStep('3', 'Pilih Lokasi', false),
    _UploadStep('4', 'Selesai', false),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 70,
            right: 70,
            top: 28,
            child: CustomPaint(
              painter: _DashedLinePainter(),
              child: const SizedBox(height: 1),
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
                            color: step.active
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
                          child: Text(
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
                            color: step.active
                                ? AppColors.deepForest
                                : const Color(0xFF6B7280),
                            fontSize: 13.5,
                            height: 1,
                            fontWeight:
                                step.active ? FontWeight.w800 : FontWeight.w700,
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

class _PhotoSectionTitle extends StatelessWidget {
  const _PhotoSectionTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih foto terbaikmu 🏔️',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 28,
            height: 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Foto yang bagus akan membuat ceritamu\nlebih bermakna.',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 15,
            height: 1.52,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class _PhotoPreviewCard extends StatelessWidget {
  const _PhotoPreviewCard({required this.image});

  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 193,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: image == null
          ? Image.asset(
              'img/create/Upload.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0.42, 0),
            )
          : Image.file(
              File(image!.path),
              fit: BoxFit.cover,
            ),
    );
  }
}

class _PhotoDots extends StatelessWidget {
  const _PhotoDots();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(4, (index) {
          return Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color:
                  index == 0 ? AppColors.forestGreen : const Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.onPickImage});

  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PhotoActionCard(
            icon: Icons.add_rounded,
            title: 'Tambah Foto',
            caption: 'Maks. 10 foto',
            onTap: onPickImage,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _PhotoActionCard(
            icon: Icons.image_outlined,
            title: 'Pilih dari Galeri',
            onTap: onPickImage,
          ),
        ),
      ],
    );
  }
}

class _PhotoActionCard extends StatelessWidget {
  const _PhotoActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.caption,
  });

  final IconData icon;
  final String title;
  final String? caption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.deepForest, size: 38),
            const SizedBox(height: 20),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 15.5,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            if (caption != null) ...[
              const SizedBox(height: 13),
              Text(
                caption!,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.forestGreen,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F1B4332),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Lanjut',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(width: 18),
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 29,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDADADA)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    const dashWidth = 7.0;
    const gap = 9.0;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, 0),
        Offset((x + dashWidth).clamp(0, size.width), 0),
        paint,
      );
      x += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UploadStep {
  const _UploadStep(this.number, this.label, this.active);

  final String number;
  final String label;
  final bool active;
}
