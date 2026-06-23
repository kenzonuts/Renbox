import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'renbok_logo.dart';

enum AppTopHeaderVariant { surface, overlay }

class AppTopHeader extends StatelessWidget {
  const AppTopHeader({
    super.key,
    this.variant = AppTopHeaderVariant.surface,
    this.height = 72,
    this.horizontalPadding = 20,
    this.logoSize = 26,
    this.showSearch = true,
    this.showNotification = true,
    this.showProfile = true,
    this.notificationBadge = '3',
    this.avatarUrl,
    this.trailingIcon,
    this.onSearchTap,
    this.onNotificationTap,
    this.onProfileTap,
    this.onTrailingTap,
  });

  final AppTopHeaderVariant variant;
  final double height;
  final double horizontalPadding;
  final double logoSize;
  final bool showSearch;
  final bool showNotification;
  final bool showProfile;
  final String? notificationBadge;
  final String? avatarUrl;
  final IconData? trailingIcon;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[
      if (showSearch)
        _HeaderIconButton(
          icon: Icons.search_rounded,
          variant: variant,
          onTap: onSearchTap,
        ),
      if (showNotification)
        _HeaderIconButton(
          icon: Icons.notifications_none_rounded,
          variant: variant,
          badge: notificationBadge,
          onTap: onNotificationTap,
        ),
      if (showProfile)
        _HeaderAvatar(
          variant: variant,
          avatarUrl: avatarUrl,
          onTap: onProfileTap,
        ),
      if (trailingIcon != null)
        _HeaderIconButton(
          icon: trailingIcon!,
          variant: variant,
          onTap: onTrailingTap,
        ),
    ];

    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: RenbokLogo(size: logoSize, showSubtitle: true),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.variant,
    this.badge,
    this.onTap,
  });

  final IconData icon;
  final AppTopHeaderVariant variant;
  final String? badge;
  final VoidCallback? onTap;

  bool get _isOverlay => variant == AppTopHeaderVariant.overlay;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: 22,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              if (_isOverlay)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.82),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.62),
                    ),
                  ),
                ),
              Icon(icon, color: AppColors.deepForest, size: 27),
              if (badge != null)
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    height: 16,
                    constraints: const BoxConstraints(minWidth: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.notificationDot,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isOverlay ? Colors.white : AppColors.cream,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      badge!,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 8,
                        height: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({
    required this.variant,
    this.avatarUrl,
    this.onTap,
  });

  final AppTopHeaderVariant variant;
  final String? avatarUrl;
  final VoidCallback? onTap;

  bool get _isOverlay => variant == AppTopHeaderVariant.overlay;

  @override
  Widget build(BuildContext context) {
    final borderColor = _isOverlay ? Colors.white : AppColors.cream;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.stone,
                border: Border.all(color: borderColor, width: 2),
                image: avatarUrl != null
                    ? DecorationImage(
                        image: NetworkImage(avatarUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                boxShadow: _isOverlay
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: avatarUrl == null
                  ? const Icon(
                      Icons.person_rounded,
                      color: AppColors.deepForest,
                      size: 20,
                    )
                  : null,
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
