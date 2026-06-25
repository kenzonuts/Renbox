import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'premium_bottom_nav.dart';

class RenbokBottomNavigation extends StatelessWidget {
  const RenbokBottomNavigation({
    super.key,
    this.currentIndex = 0,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return PremiumBottomNav(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/main');
          case 1:
            context.go('/main/explore');
          case 2:
            context.go('/main/create');
          case 3:
            context.go('/main/activity');
          case 4:
            context.go('/main/profile');
        }
      },
    );
  }
}
