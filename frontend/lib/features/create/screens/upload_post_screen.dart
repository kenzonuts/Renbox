import 'dart:io';

import 'package:flutter/foundation.dart';
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
  final _storyController = TextEditingController(
    text: 'Sunrise di Gunung Prau benar-benar luar biasa.\n'
        'Udara dingin, langit jernih, dan pemandangan 360°\n'
        'yang bikin semua lelah perjalanan terbayar.\n'
        'Tempat ini selalu punya cerita yang nggak\n'
        'terlupakan.',
  );

  int _step = 0;
  XFile? _image;

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

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

  void _next() {
    if (_step < 3) setState(() => _step += 1);
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step -= 1);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final preview = _step == 3;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: preview ? Colors.white : AppColors.cream,
      ),
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24, 20, 24, bottomPadding + 104),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FlowHeader(
                  preview: preview,
                  onBack: _back,
                  onEdit: preview ? () => setState(() => _step = 2) : null,
                ),
                if (!preview) ...[
                  const SizedBox(height: 24),
                  _StepIndicator(currentStep: _step),
                  const SizedBox(height: 30),
                ] else
                  const SizedBox(height: 18),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: KeyedSubtree(
                    key: ValueKey(_step),
                    child: switch (_step) {
                      0 => _StepOne(onPickImage: _pickImage, image: _image),
                      1 => _StepTwo(
                          controller: _storyController,
                          image: _image,
                          onEditPhoto: _pickImage,
                        ),
                      2 => const _StepThree(),
                      _ => const _StepFour(),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: preview ? Colors.white : AppColors.cream,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              child: _BottomActions(
                step: _step,
                onBack: _back,
                onNext: _next,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FlowHeader extends StatelessWidget {
  const _FlowHeader({
    required this.preview,
    required this.onBack,
    this.onEdit,
  });

  final bool preview;
  final VoidCallback onBack;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preview ? 92 : 104,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: preview ? 8 : 0,
            child: _CircleButton(onTap: onBack),
          ),
          Positioned(
            left: preview ? 66 : 54,
            right: preview ? 82 : 84,
            top: preview ? 14 : 7,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                preview ? 'Preview Petualangan' : 'Upload Petualangan',
                maxLines: 1,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: preview ? 32 : 22,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: preview ? 66 : 54,
            right: 4,
            top: preview ? 58 : 48,
            child: Text(
              preview
                  ? 'Pastikan semuanya sudah benar.'
                  : 'Bagikan cerita dari perjalananmu\ndan inspirasi untuk explorer lainnya.',
              maxLines: preview ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF6B7280),
                fontSize: preview ? 15 : 14.5,
                height: preview ? 1 : 1.42,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: preview ? 8 : 4,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                height: preview ? 48 : 50,
                padding: EdgeInsets.symmetric(horizontal: preview ? 22 : 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(preview ? 18 : 16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  preview ? 'Edit' : 'Draft',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: preview ? 17 : 15,
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
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.deepForest,
          size: 30,
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  static const _labels = ['Pilih Foto', 'Ceritakan', 'Pilih Lokasi', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: Stack(
        children: [
          Positioned(
            left: 70,
            right: 70,
            top: 28,
            child: CustomPaint(
              painter: _DashedLinePainter(activeFraction: currentStep / 3),
              child: const SizedBox(height: 1),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(4, (index) {
              final completed = index < currentStep;
              final active = index == currentStep;
              final green = completed || active;
              return SizedBox(
                width: 72,
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: green ? AppColors.forestGreen : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 24,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: completed
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 30)
                          : Text(
                              '${index + 1}',
                              style: GoogleFonts.plusJakartaSans(
                                color: active
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
                      _labels[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.plusJakartaSans(
                        color: green
                            ? AppColors.deepForest
                            : const Color(0xFF6B7280),
                        fontSize: 13.2,
                        height: 1,
                        fontWeight: green ? FontWeight.w800 : FontWeight.w700,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _StepOne extends StatelessWidget {
  const _StepOne({required this.onPickImage, required this.image});

  final VoidCallback onPickImage;
  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Pilih foto terbaikmu 🏔️',
          subtitle: 'Foto yang bagus akan membuat ceritamu\nlebih bermakna.',
        ),
        const SizedBox(height: 28),
        _MainPhotoCard(image: image),
        const SizedBox(height: 20),
        const _PhotoDots(),
        const SizedBox(height: 34),
        Row(
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
        ),
      ],
    );
  }
}

class _StepTwo extends StatelessWidget {
  const _StepTwo({
    required this.controller,
    required this.image,
    required this.onEditPhoto,
  });

  final TextEditingController controller;
  final XFile? image;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Ceritakan pengalamanmu 🌿',
          subtitle: 'Apa yang kamu rasakan di tempat ini?',
          compactTitle: true,
        ),
        const SizedBox(height: 22),
        _StoryEditor(controller: controller),
        const SizedBox(height: 22),
        const _TipsCard(),
        const SizedBox(height: 24),
        _SelectedPhotoSummary(image: image, onEdit: onEditPhoto),
      ],
    );
  }
}

class _StepThree extends StatelessWidget {
  const _StepThree();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: 'Pilih lokasi & detail 📍',
          subtitle: 'Beri tahu di mana petualanganmu terjadi.',
        ),
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
    );
  }
}

class _StepFour extends StatelessWidget {
  const _StepFour();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _PreviewPostCard(),
        SizedBox(height: 18),
        _CommunityNotice(),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
    this.compactTitle = false,
  });

  final String title;
  final String subtitle;
  final bool compactTitle;

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      maxLines: compactTitle ? 1 : 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.plusJakartaSans(
        color: AppColors.deepForest,
        fontSize: compactTitle ? 29 : 28,
        height: 1.1,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        compactTitle
            ? SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: titleWidget,
                ),
              )
            : titleWidget,
        const SizedBox(height: 22),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 16,
            height: 1.52,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class _MainPhotoCard extends StatelessWidget {
  const _MainPhotoCard({required this.image});

  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: double.infinity,
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
      child: _PhotoImage(image: image, fit: BoxFit.cover),
    );
  }
}

class _PhotoImage extends StatelessWidget {
  const _PhotoImage({this.image, this.fit = BoxFit.cover});

  final XFile? image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (image != null && !kIsWeb) {
      return Image.file(File(image!.path), fit: fit);
    }
    return Image.asset(
      'img/create/Upload.png',
      fit: fit,
      alignment: const Alignment(0.42, 0),
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
        border: Border.all(color: AppColors.stone.withValues(alpha: 0.5)),
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
              decoration: const InputDecoration(
                hintText: 'Apa cerita terbaik dari perjalananmu?',
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
              '122/500',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.forestGreen,
                fontSize: 13,
                fontWeight: FontWeight.w800,
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
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 15,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: '💡  Tips: ',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(
              text:
                  'Cerita yang jujur dan detail akan menginspirasi explorer lainnya.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedPhotoSummary extends StatelessWidget {
  const _SelectedPhotoSummary({required this.image, required this.onEdit});

  final XFile? image;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
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
              width: 96,
              height: 96,
              child: _PhotoImage(image: image),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunrise di Gunung Prau',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '🏔 Gunung Prau, Dieng',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.forestGreen,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Gunung',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
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
            child: const SizedBox(
              width: 72,
              height: 72,
              child: _PhotoImage(),
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
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Dieng, Jawa Tengah',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cream.withValues(alpha: 0.74),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Ubah',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.forestGreen,
                fontSize: 13,
                fontWeight: FontWeight.w800,
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
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Pilih kategori yang sesuai',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Container(
                width: 82,
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
                      color: category.selected
                          ? Colors.white
                          : AppColors.forestGreen,
                      size: 28,
                    ),
                    const SizedBox(height: 11),
                    Text(
                      category.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: category.selected
                            ? Colors.white
                            : AppColors.deepForest,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
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
          const Icon(
            Icons.card_travel_rounded,
            color: AppColors.forestGreen,
            size: 40,
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
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  'Cek progress dan raih badge explorer.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
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
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Cerita akan ditampilkan di feed publik.',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '🌐  Publik⌄',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PreviewPostCard extends StatelessWidget {
  const _PreviewPostCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroPreviewImage(),
          Padding(
            padding: EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AuthorBlock(),
                SizedBox(height: 14),
                _PostTitle(),
                SizedBox(height: 13),
                _PostDescription(),
                SizedBox(height: 15),
                _LocationRow(),
                SizedBox(height: 16),
                _PreviewActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPreviewImage extends StatelessWidget {
  const _HeroPreviewImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _PhotoImage(),
          Positioned(
            left: 18,
            top: 18,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.forestGreen,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.terrain_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Gunung',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 18,
            top: 18,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.48),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '1/5',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthorBlock extends StatelessWidget {
  const _AuthorBlock();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ClipOval(
          child: SizedBox(width: 42, height: 42, child: _PhotoImage()),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'adventure.kay',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.deepForest,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(Icons.verified_rounded,
                      color: AppColors.forestGreen, size: 19),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Baru saja • Publik 🌐',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostTitle extends StatelessWidget {
  const _PostTitle();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(
        'Sunrise di Gunung Prau',
        maxLines: 1,
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.deepForest,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _PostDescription extends StatelessWidget {
  const _PostDescription();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sunrise di Gunung Prau benar-benar luar biasa.\n\n'
      'Udara dingin, langit jernih, dan pemandangan 360° membuat semua rasa lelah terbayar.',
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.plusJakartaSans(
        color: const Color(0xFF6B7280),
        fontSize: 14.2,
        height: 1.42,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_rounded,
            color: Color(0xFF6B7280), size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Gunung Prau, Dieng, Jawa Tengah',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF6B7280),
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewActions extends StatelessWidget {
  const _PreviewActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite_border_rounded,
            color: Color(0xFFE94B6A), size: 28),
        const SizedBox(width: 10),
        Text('0',
            style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        const SizedBox(width: 44),
        const Icon(Icons.chat_bubble_outline_rounded,
            color: Color(0xFF6B7280), size: 27),
        const SizedBox(width: 10),
        Text('0',
            style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        const Spacer(),
        const Icon(Icons.bookmark_border_rounded,
            color: AppColors.deepForest, size: 29),
      ],
    );
  }
}

class _CommunityNotice extends StatelessWidget {
  const _CommunityNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
      decoration: BoxDecoration(
        color: AppColors.forestGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user_outlined,
              color: AppColors.forestGreen, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 13.5,
                  height: 1.38,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  const TextSpan(
                    text: 'Dengan memposting, kamu menyetujui ',
                  ),
                  TextSpan(
                    text: 'Panduan Komunitas',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.forestGreen,
                      fontSize: 13.5,
                      height: 1.38,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(text: ' RENBOK.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.step,
    required this.onBack,
    required this.onNext,
  });

  final int step;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    if (step == 0) {
      return _PrimaryButton(label: 'Lanjut', onTap: onNext);
    }
    if (step == 3) {
      return const _PrimaryButton(label: 'Posting Petualangan 🚀');
    }
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: _SecondaryButton(onTap: onBack),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: step == 2 ? 14 : 13,
          child: _PrimaryButton(
            label: step == 2 ? 'Lanjut ke Preview' : 'Lanjut',
            onTap: onNext,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: stepButtonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.forestGreen,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x242D6A4F),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (!label.contains('🚀')) ...[
              const SizedBox(width: 16),
              const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 28),
            ],
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: stepButtonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border:
              Border.all(color: AppColors.deepForest.withValues(alpha: 0.12)),
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
            const Icon(Icons.arrow_back_rounded,
                color: AppColors.deepForest, size: 25),
            const SizedBox(width: 12),
            Text(
              'Kembali',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
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
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
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

class _CategoryItem {
  const _CategoryItem(this.icon, this.label, this.selected);

  final IconData icon;
  final String label;
  final bool selected;
}

const stepButtonHeight = 56.0;
