import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/categories.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/api_service.dart';

const _gridGap = 12.0;
const _horizontalPadding = 24.0;
const _cardHeight = 132.0;
const _cardLabelHeight = 38.0;

const Map<String, Alignment> _interestImageAlignments = {
  'Gunung': Alignment(-0.45, -0.35),
  'Camping': Alignment(0.55, 0.15),
  'Air Terjun': Alignment(0.1, -0.1),
  'Pantai': Alignment(0.7, 0.25),
  'Hutan': Alignment(-0.3, 0.2),
  'Danau': Alignment(-0.15, -0.05),
  'Fotografi Alam': Alignment(0.35, 0.3),
};

class InterestSetupScreen extends ConsumerStatefulWidget {
  const InterestSetupScreen({super.key});

  @override
  ConsumerState<InterestSetupScreen> createState() =>
      _InterestSetupScreenState();
}

class _InterestSetupScreenState extends ConsumerState<InterestSetupScreen> {
  final Set<String> _selected = {'Gunung', 'Air Terjun', 'Danau'};

  Future<void> _save({bool skip = false}) async {
    if (!skip && _selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih minimal satu minat')),
      );
      return;
    }

    if (!skip && !AppConstants.useDummyAuth) {
      try {
        await ref.read(apiServiceProvider).updateProfile({
          'interests': _selected.toList(),
        });
      } catch (_) {
        // Continue even if API fails (offline dev)
      }
    }

    await ref.read(authStorageProvider).setInterestsSetupComplete(true);
    if (mounted) context.go('/main');
  }

  void _toggle(String interest) {
    setState(() {
      if (_selected.contains(interest)) {
        _selected.remove(interest);
      } else {
        _selected.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight =
              (constraints.maxHeight * 0.28).clamp(210.0, 270.0);

          return SizedBox(
            height: constraints.maxHeight,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: headerHeight + 28,
                  child: Image.asset(
                    'img/img-minat/minat.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  height: headerHeight + 28,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.24),
                        Colors.white.withValues(alpha: 0.03),
                        Colors.white.withValues(alpha: 0.18),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'img/logo/Logo.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => _save(skip: true),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF5F6673),
                            textStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Lewati'),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  top: headerHeight,
                  child: _InterestPanel(
                    availableHeight: constraints.maxHeight - headerHeight,
                    selected: _selected,
                    onToggle: _toggle,
                    onContinue: _save,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InterestPanel extends StatelessWidget {
  const _InterestPanel({
    required this.availableHeight,
    required this.selected,
    required this.onToggle,
    required this.onContinue,
  });

  final double availableHeight;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final Future<void> Function({bool skip}) onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: availableHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
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
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 42,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFDADDE2),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                _horizontalPadding,
                18,
                _horizontalPadding,
                8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apa yang ingin kamu\njelajahi?',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      height: 1.14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF101820),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pilih beberapa kategori yang paling kamu sukai.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF69707C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InterestGridRow(
                    labels: interestOptions.sublist(0, 3),
                    selected: selected,
                    onToggle: onToggle,
                  ),
                  const SizedBox(height: _gridGap),
                  _InterestGridRow(
                    labels: interestOptions.sublist(3, 6),
                    selected: selected,
                    onToggle: onToggle,
                  ),
                  const SizedBox(height: _gridGap),
                  _InterestGridRow(
                    labels: [interestOptions[6]],
                    selected: selected,
                    onToggle: onToggle,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.tune_rounded,
                        size: 20,
                        color: AppColors.forestGreen,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${selected.length} kategori dipilih',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF5F6673),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              _horizontalPadding,
              8,
              _horizontalPadding,
              16,
            ),
            child: _ContinueButton(onPressed: () => onContinue()),
          ),
        ],
      ),
    );
  }
}

class _InterestGridRow extends StatelessWidget {
  const _InterestGridRow({
    required this.labels,
    required this.selected,
    required this.onToggle,
  });

  final List<String> labels;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardHeight,
      child: Row(
        children: [
          for (var index = 0; index < 3; index++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 2 ? 0 : _gridGap),
                child: index < labels.length
                    ? _InterestCard(
                        label: labels[index],
                        selected: selected.contains(labels[index]),
                        imageAlignment:
                            _interestImageAlignments[labels[index]] ??
                                Alignment.center,
                        onTap: () => onToggle(labels[index]),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
        ],
      ),
    );
  }
}

class _InterestCard extends StatelessWidget {
  const _InterestCard({
    required this.label,
    required this.selected,
    required this.imageAlignment,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Alignment imageAlignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const checkSize = 28.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'img/img-minat/minat.png',
                        fit: BoxFit.cover,
                        alignment: imageAlignment,
                      ),
                    ),
                    Container(
                      height: _cardLabelHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF101820),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: checkSize,
                    height: checkSize,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF2E7D32)
                          : Colors.white.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: selected
                        ? Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: checkSize * 0.72,
                          )
                        : null,
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

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF145A36), Color(0xFF2E7A4A)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                'Lanjutkan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
