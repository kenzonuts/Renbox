import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class PremiumBottomNav extends StatelessWidget {
  const PremiumBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: 110 + safeBottom,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 88 + safeBottom,
              padding: EdgeInsets.fromLTRB(14, 10, 14, safeBottom + 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 26,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _NavItem(
                      label: 'Home',
                      icon: Icons.home_outlined,
                      selectedIcon: Icons.home_rounded,
                      selected: currentIndex == 0,
                      onTap: () => _select(0),
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      label: 'Explore',
                      icon: Icons.explore_outlined,
                      selectedIcon: Icons.explore_rounded,
                      selected: currentIndex == 1,
                      onTap: () => _select(1),
                    ),
                  ),
                  const SizedBox(width: 74),
                  Expanded(
                    child: _NavItem(
                      label: 'Activity',
                      icon: Icons.notifications_none_rounded,
                      selectedIcon: Icons.notifications_rounded,
                      selected: currentIndex == 3,
                      showDot: currentIndex != 3,
                      onTap: () => _select(3),
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      label: 'Profile',
                      icon: Icons.person_outline_rounded,
                      selectedIcon: Icons.person_rounded,
                      selected: currentIndex == 4,
                      onTap: () => _select(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: _GuideButton(
              selected: currentIndex == 2,
              onTap: () => _select(2),
            ),
          ),
        ],
      ),
    );
  }

  void _select(int index) {
    HapticFeedback.lightImpact();
    onTap(index);
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.selected,
    required this.onTap,
    this.showDot = false,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool selected;
  final bool showDot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.forestGreen : const Color(0xFF6B7280);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(selected ? selectedIcon : icon, size: 22, color: color),
                  if (showDot)
                    Positioned(
                      right: -8,
                      top: -5,
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: AppColors.notificationDot,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 8,
                              height: 1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                label,
                maxLines: 1,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  height: 1,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideButton extends StatelessWidget {
  const _GuideButton({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: 'Guide',
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.forestGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3A1B4332),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.landscape_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 2),
                Text(
                  'Guide',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
