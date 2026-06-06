import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/theme/app_colors.dart';
import 'bottom_nav_bar_shape.dart';

class PremiumBottomNav extends StatelessWidget {
  const PremiumBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItemData(
      label: 'Home',
      outlinedIcon: Icons.home_outlined,
      filledIcon: Icons.home_rounded,
    ),
    _NavItemData(
      label: 'Explore',
      outlinedIcon: Icons.explore_outlined,
      filledIcon: Icons.explore_rounded,
    ),
    _NavItemData(
      label: 'Activity',
      outlinedIcon: Icons.favorite_outline_rounded,
      filledIcon: Icons.favorite_rounded,
    ),
    _NavItemData(
      label: 'Profile',
      outlinedIcon: Icons.person_outline_rounded,
      filledIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    final barHeight = AppLayout.bottomNavHeight + safeBottom;

    return SizedBox(
      height: AppLayout.bottomNavTotalHeight(context),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom bar — lingkaran memotong tepi atas
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBarShape(
              height: barHeight,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: _NavTab(
                              item: _items[0],
                              selected: currentIndex == 0,
                              onTap: () => onTap(0),
                            ),
                          ),
                          Expanded(
                            child: _NavTab(
                              item: _items[1],
                              selected: currentIndex == 1,
                              onTap: () => onTap(1),
                            ),
                          ),
                          SizedBox(width: AppLayout.createButtonSize + 8),
                          Expanded(
                            child: _NavTab(
                              item: _items[2],
                              selected: currentIndex == 3,
                              onTap: () => onTap(3),
                            ),
                          ),
                          Expanded(
                            child: _NavTab(
                              item: _items[3],
                              selected: currentIndex == 4,
                              onTap: () => onTap(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (safeBottom > 0)
                    SizedBox(height: safeBottom - 4)
                  else
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.deepForest.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Tombol Create — center tepat di garis potong bar (y = protrusion)
          Positioned(
            top: AppLayout.createButtonOffsetY,
            left: 0,
            right: 0,
            child: Center(
              child: _CreateFab(onTap: () => onTap(2)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.label,
    required this.outlinedIcon,
    required this.filledIcon,
  });

  final String label;
  final IconData outlinedIcon;
  final IconData filledIcon;
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItemData item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.forestGreen : AppColors.textMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: AppLayout.bottomNavHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? item.filledIcon : item.outlinedIcon,
                color: color,
                size: selected ? 25 : 24,
              ),
              const SizedBox(height: 3),
              Text(
                item.label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                width: selected ? 4 : 0,
                height: selected ? 4 : 0,
                decoration: const BoxDecoration(
                  color: AppColors.forestGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateFab extends StatefulWidget {
  const _CreateFab({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_CreateFab> createState() => _CreateFabState();
}

class _CreateFabState extends State<_CreateFab> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: Container(
          width: AppLayout.createButtonSize,
          height: AppLayout.createButtonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.deepForest,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepForest.withValues(alpha: 0.28),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
