import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/renbok_feature_theme.dart';
import '../../main/widgets/renbok_bottom_navigation.dart';
import '../models/feature_item.dart';
import '../widgets/all_features_header.dart';
import '../widgets/feature_section.dart';
import '../widgets/hero_banner.dart';
import 'feature_placeholder_screen.dart';

class AllFeaturesScreen extends StatelessWidget {
  const AllFeaturesScreen({super.key});

  static const List<FeatureSectionData> _sections = [
    FeatureSectionData(
      title: 'PERENCANAAN',
      icon: Icons.map_outlined,
      features: [
        FeatureItem(
          title: 'Destinasi',
          description:
              'Temukan ribuan gunung, pantai, air terjun dan tempat menarik.',
          icon: Icons.map_rounded,
        ),
        FeatureItem(
          title: 'Panduan Pendakian',
          description:
              'Informasi jalur, level, perlengkapan, dan estimasi pendakian.',
          icon: Icons.hiking_rounded,
        ),
        FeatureItem(
          title: 'Camping Ground',
          description: 'Temukan lokasi camping terbaik di seluruh Indonesia.',
          icon: Icons.cabin_rounded,
        ),
      ],
    ),
    FeatureSectionData(
      title: 'KONDISI ALAM',
      icon: Icons.wb_cloudy_outlined,
      features: [
        FeatureItem(
          title: 'Cuaca Gunung',
          description: 'Prakiraan cuaca gunung secara akurat dan terkini.',
          icon: Icons.wb_sunny_rounded,
        ),
        FeatureItem(
          title: 'Status Jalur',
          description: 'Informasi buka tutup jalur pendakian secara real-time.',
          icon: Icons.warning_rounded,
        ),
        FeatureItem(
          title: 'Aktivitas Gunung',
          description: 'Pantau aktivitas gunung api di seluruh Indonesia.',
          icon: Icons.volcano_rounded,
        ),
        FeatureItem(
          title: 'Pasang Surut Pantai',
          description:
              'Informasi pasang surut air laut untuk aktivitas pantai.',
          icon: Icons.waves_rounded,
        ),
      ],
    ),
    FeatureSectionData(
      title: 'EKSPLORASI',
      icon: Icons.explore_outlined,
      features: [
        FeatureItem(
          title: 'Cerita Komunitas',
          description: 'Baca cerita petualangan dari para explorer.',
          icon: Icons.menu_book_rounded,
        ),
        FeatureItem(
          title: 'Temukan Teman Hiking',
          description: 'Cari teman baru untuk petualanganmu.',
          icon: Icons.groups_rounded,
        ),
        FeatureItem(
          title: 'Spot Foto',
          description: 'Temukan spot foto terbaik di setiap destinasi.',
          icon: Icons.camera_alt_rounded,
        ),
        FeatureItem(
          title: 'Hidden Gem',
          description: 'Temukan tempat tersembunyi yang memukau.',
          icon: Icons.star_rounded,
        ),
      ],
    ),
    FeatureSectionData(
      title: 'PERSIAPAN',
      icon: Icons.backpack_outlined,
      compactSingleRow: true,
      features: [
        FeatureItem(
          title: 'Checklist Barang',
          description: 'Checklist perlengkapan sesuai jenis petualangan.',
          icon: Icons.checklist_rounded,
        ),
        FeatureItem(
          title: 'Trip Planner',
          description: 'Rencanakan itinerary perjalananmu.',
          icon: Icons.route_rounded,
        ),
        FeatureItem(
          title: 'Transportasi',
          description: 'Informasi transportasi menuju lokasi destinasi.',
          icon: Icons.directions_bus_rounded,
        ),
        FeatureItem(
          title: 'Estimasi Budget',
          description: 'Perkiraan biaya perjalanan secara detail.',
          icon: Icons.account_balance_wallet_rounded,
        ),
      ],
    ),
    FeatureSectionData(
      title: 'EXPLORER',
      icon: Icons.emoji_events_outlined,
      compactSingleRow: true,
      features: [
        FeatureItem(
          title: 'Passport Explorer',
          description: 'Kumpulkan stamp di setiap petualanganmu.',
          icon: Icons.card_membership_rounded,
        ),
        FeatureItem(
          title: 'Badge',
          description: 'Dapatkan badge dari setiap pencapaianmu.',
          icon: Icons.workspace_premium_rounded,
        ),
        FeatureItem(
          title: 'Statistik',
          description: 'Lihat statistik perjalanan dan pencapaianmu.',
          icon: Icons.bar_chart_rounded,
        ),
        FeatureItem(
          title: 'Riwayat Check-in',
          description: 'Lihat jejak petualanganmu di peta.',
          icon: Icons.location_on_rounded,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: colors.background,
        bottomNavigationBar: const RenbokBottomNavigation(currentIndex: 0),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: AllFeaturesHeader(
                  onSearchTap: () => Navigator.of(context).push(
                    CupertinoPageRoute<void>(
                      builder: (_) => const FeaturePlaceholderScreen(
                        title: 'Cari Fitur',
                        description: 'Placeholder pencarian fitur RENBOK.',
                        icon: Icons.search_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: HeroBanner()),
              for (final section in _sections)
                SliverToBoxAdapter(child: FeatureSection(section: section)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + 140,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
