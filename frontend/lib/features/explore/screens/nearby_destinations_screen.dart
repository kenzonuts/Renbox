import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../main/widgets/premium_bottom_nav.dart';

class NearbyDestinationsScreen extends StatefulWidget {
  const NearbyDestinationsScreen({super.key});

  static const routePath = '/nearby-destinations';

  @override
  State<NearbyDestinationsScreen> createState() =>
      _NearbyDestinationsScreenState();
}

class _NearbyDestinationsScreenState extends State<NearbyDestinationsScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  final Set<String> _saved = {};
  String _selectedCategory = 'Semua';
  String _sort = 'Terdekat';

  static const _categories = [
    _NearbyCategory('Semua', Icons.grid_view_rounded),
    _NearbyCategory('Gunung', Icons.terrain_rounded),
    _NearbyCategory('Air Terjun', Icons.waterfall_chart_rounded),
    _NearbyCategory('Pantai', Icons.waves_rounded),
    _NearbyCategory('Camping', Icons.change_history_rounded),
  ];

  static const _destinations = [
    NearbyDestinationData(
      title: 'Gunung Prau',
      slug: 'gunung-prau',
      location: 'Dieng, Jawa Tengah',
      distance: '6.5 km',
      rating: '4.8',
      reviews: '890',
      travelTime: '18 menit',
      status: 'Aman',
      weather: '18C - 26C',
      weatherLabel: 'Cerah Berawan',
      height: '2.565 mdpl',
      level: 'Sedang',
      imageUrl:
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=700&q=86',
    ),
    NearbyDestinationData(
      title: 'Curug Lawe',
      slug: 'curug-lawe',
      location: 'Semarang, Jawa Tengah',
      distance: '7.8 km',
      rating: '4.7',
      reviews: '612',
      travelTime: '22 menit',
      status: 'Aman',
      weather: '21C - 28C',
      weatherLabel: 'Cerah',
      height: '850 mdpl',
      level: 'Mudah',
      imageUrl:
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=700&q=86',
    ),
    NearbyDestinationData(
      title: 'Pantai Menganti',
      slug: 'pantai-menganti',
      location: 'Kebumen, Jawa Tengah',
      distance: '9.5 km',
      rating: '4.8',
      reviews: '1.102',
      travelTime: '25 menit',
      status: 'Aman',
      weather: '24C - 30C',
      weatherLabel: 'Cerah',
      height: '0 mdpl',
      level: 'Mudah',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=700&q=86',
    ),
    NearbyDestinationData(
      title: 'Telaga Menjer',
      slug: 'telaga-menjer',
      location: 'Wonosobo, Jawa Tengah',
      distance: '11.2 km',
      rating: '4.6',
      reviews: '560',
      travelTime: '28 menit',
      status: 'Aman',
      weather: '17C - 24C',
      weatherLabel: 'Cerah Berawan',
      height: '1.300 mdpl',
      level: 'Mudah',
      imageUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=700&q=86',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 132;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F5F0),
        bottomNavigationBar: const RenbokBottomNav(currentIndex: 1),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _Header(searchFocus: _searchFocusNode)),
              SliverToBoxAdapter(
                child: SearchBarField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                ),
              ),
              const SliverToBoxAdapter(child: MapPreviewCard()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 58,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return CategoryChip(
                        label: category.label,
                        icon: category.icon,
                        selected: category.label == _selectedCategory,
                        onTap: () {
                          setState(() => _selectedCategory = category.label);
                        },
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SortRow(
                  sort: _sort,
                  onSortTap: _showSortSheet,
                  onLocationTap: _showPlaceholderLocation,
                ),
              ),
              SliverList.separated(
                itemCount: _destinations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final destination = _destinations[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 6 : 0,
                      16,
                      index == _destinations.length - 1 ? bottomPadding : 0,
                    ),
                    child: NearbyDestinationCard(
                      data: destination,
                      saved: _saved.contains(destination.slug),
                      onSaveTap: () => _toggleSaved(destination.slug),
                      onNavigateTap: _showPlaceholderNavigation,
                      onDetailTap: () =>
                          context.push('/location/${destination.slug}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSaved(String slug) {
    setState(() {
      if (!_saved.add(slug)) {
        _saved.remove(slug);
      }
    });
  }

  void _showSortSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        const options = ['Terdekat', 'Rating Tertinggi', 'Waktu Tercepat'];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Urutkan Destinasi',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                for (final option in options)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      option,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight:
                            _sort == option ? FontWeight.w800 : FontWeight.w600,
                        color: const Color(0xFF12372A),
                      ),
                    ),
                    trailing: _sort == option
                        ? const Icon(Icons.check_rounded,
                            color: Color(0xFF006B4F))
                        : null,
                    onTap: () {
                      setState(() => _sort = option);
                      context.pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPlaceholderLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menggunakan lokasi kamu saat ini.')),
    );
  }

  void _showPlaceholderNavigation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi akan segera tersedia.')),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.searchFocus});

  final FocusNode searchFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/main/explore');
              }
            },
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dekat Denganmu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Temukan destinasi terbaik di dekat lokasimu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleIconButton(
            icon: Icons.search_rounded,
            onTap: searchFocus.requestFocus,
          ),
          const SizedBox(width: 10),
          CircleIconButton(
            icon: Icons.tune_rounded,
            onTap: () => _showFilterSheet(context),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Destinasi',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Filter kategori, jarak, dan tingkat jalur akan tersedia di versi berikutnya.',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      shadowColor: Colors.black.withValues(alpha: 0.12),
      elevation: 8,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: const Color(0xFF12372A), size: 25),
        ),
      ),
    );
  }
}

class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(33),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 26,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: const Color(0xFF006B4F),
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF12372A),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 18, right: 10),
              child: Icon(Icons.search_rounded,
                  color: Color(0xFF006B4F), size: 25),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 56),
            hintText: 'Cari destinasi terdekat...',
            hintStyle: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF8B93A2),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: const EdgeInsets.only(top: 22),
          ),
        ),
      ),
    );
  }
}

class MapPreviewCard extends StatelessWidget {
  const MapPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: 210,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const CustomPaint(painter: _MapPreviewPainter()),
              Positioned(
                left: 206,
                top: 42,
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A9DF2).withValues(alpha: 0.13),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A9DF2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(left: 106, top: 30, child: _MapPin()),
              const Positioned(left: 174, top: 100, child: _MapPin()),
              const Positioned(right: 86, top: 30, child: _MapPin()),
              Positioned(
                left: 18,
                bottom: 16,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                  elevation: 8,
                  shadowColor: Colors.black.withValues(alpha: 0.12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(29),
                    onTap: () {},
                    child: Container(
                      height: 58,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.my_location_rounded,
                              color: Color(0xFF006B4F), size: 25),
                          const SizedBox(width: 10),
                          Text(
                            'Lokasiku',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF12372A),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
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

class _MapPreviewPainter extends CustomPainter {
  const _MapPreviewPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE8F0E7),
          Color(0xFFF2F2E9),
          Color(0xFFDDEBDD),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final water = Paint()
      ..color = const Color(0xFFAED5E8).withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    final lake = Path()
      ..moveTo(0, 98)
      ..cubicTo(44, 82, 46, 130, 88, 120)
      ..cubicTo(116, 112, 118, 158, 70, 170)
      ..cubicTo(32, 178, 8, 150, 0, 140)
      ..close();
    canvas.drawPath(lake, water);

    final landStroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.74)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    for (final path in [
      Path()
        ..moveTo(-20, 30)
        ..cubicTo(58, 58, 108, 40, 168, 72)
        ..cubicTo(236, 108, 300, 58, size.width + 16, 86),
      Path()
        ..moveTo(8, size.height + 18)
        ..cubicTo(82, 116, 138, 138, 196, 82)
        ..cubicTo(246, 34, 300, 64, size.width + 20, 24),
      Path()
        ..moveTo(104, -8)
        ..cubicTo(84, 42, 116, 78, 96, 126)
        ..cubicTo(80, 166, 116, 184, 132, size.height + 10),
    ]) {
      canvas.drawPath(path, landStroke);
    }

    final detail = Paint()
      ..color = const Color(0xFFB8CCB8).withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (var i = 0; i < 9; i++) {
      final y = 10.0 + i * 23;
      final path = Path()
        ..moveTo(0, y)
        ..cubicTo(88, y - 22, 138, y + 28, size.width, y - 10);
      canvas.drawPath(path, detail);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 48,
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Icon(Icons.location_on_rounded,
              color: Color(0xFF006B4F), size: 48),
          Positioned(
            top: 9,
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                color: Color(0xFF006B4F),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.terrain_rounded,
                  color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF006B4F) : Colors.white,
      borderRadius: BorderRadius.circular(26),
      shadowColor: Colors.black.withValues(alpha: 0.09),
      elevation: 7,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : const Color(0xFF006B4F),
                size: 21,
              ),
              const SizedBox(width: 9),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: selected ? Colors.white : const Color(0xFF12372A),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortRow extends StatelessWidget {
  const SortRow({
    super.key,
    required this.sort,
    required this.onSortTap,
    required this.onLocationTap,
  });

  final String sort;
  final VoidCallback onSortTap;
  final VoidCallback onLocationTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Row(
        children: [
          Text(
            'Urutkan:',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF7A8494),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 12),
          _PillButton(
            label: sort,
            icon: Icons.keyboard_arrow_down_rounded,
            onTap: onSortTap,
          ),
          const Spacer(),
          _PillButton(
            label: 'Lokasi Saya',
            leadingIcon: Icons.my_location_rounded,
            onTap: onLocationTap,
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.leadingIcon,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, color: const Color(0xFF006B4F), size: 21),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF12372A),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: const Color(0xFF12372A), size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyDestinationCard extends StatelessWidget {
  const NearbyDestinationCard({
    super.key,
    required this.data,
    required this.saved,
    required this.onSaveTap,
    required this.onNavigateTap,
    required this.onDetailTap,
  });

  final NearbyDestinationData data;
  final bool saved;
  final VoidCallback onSaveTap;
  final VoidCallback onNavigateTap;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.055),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DestinationImage(data: data),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF006B4F),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSaveTap,
                        child: Icon(
                          saved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: const Color(0xFF006B4F),
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Color(0xFF006B4F), size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          data.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF6B7280),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.starGold, size: 17),
                      const SizedBox(width: 4),
                      Text(
                        '${data.rating} (${data.reviews})',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF6B7280),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.directions_car_filled_rounded,
                          color: Color(0xFF12372A), size: 15),
                      const SizedBox(width: 5),
                      Text(
                        data.travelTime,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF6B7280),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Expanded(
                        child: InfoChip(
                          icon: Icons.verified_user_outlined,
                          title: data.status,
                          subtitle: 'Status Jalur',
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: InfoChip(
                          icon: Icons.thermostat_rounded,
                          title: data.weather,
                          subtitle: data.weatherLabel,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: InfoChip(
                          icon: Icons.terrain_rounded,
                          title: data.height,
                          subtitle: 'Level ${data.level}',
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: _CardButton(
                          label: 'Mulai Navigasi',
                          icon: Icons.near_me_rounded,
                          outlined: true,
                          onTap: onNavigateTap,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _CardButton(
                          label: 'Lihat Detail',
                          icon: Icons.arrow_forward_rounded,
                          outlined: false,
                          onTap: onDetailTap,
                        ),
                      ),
                    ],
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

class _DestinationImage extends StatelessWidget {
  const _DestinationImage({required this.data});

  final NearbyDestinationData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 116,
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: data.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.stone),
              errorWidget: (_, __, ___) => Container(color: AppColors.stone),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                  stops: const [0, 0.58, 1],
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                  color: const Color(0xFF12372A).withValues(alpha: 0.76),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.route_rounded,
                        color: Colors.white, size: 13),
                    const SizedBox(width: 4),
                    Text(
                      data.distance,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF006B4F), size: 18),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF006B4F),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    height: 1,
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

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.label,
    required this.icon,
    required this.outlined,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool outlined;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: outlined ? Colors.white : const Color(0xFF006B4F),
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(21),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            border: outlined
                ? Border.all(color: const Color(0xFF006B4F), width: 1)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: outlined ? const Color(0xFF006B4F) : Colors.white,
                size: 17,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: outlined ? const Color(0xFF006B4F) : Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
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

class RenbokBottomNav extends StatelessWidget {
  const RenbokBottomNav({super.key, required this.currentIndex});

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

class NearbyDestinationData {
  const NearbyDestinationData({
    required this.title,
    required this.slug,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.travelTime,
    required this.status,
    required this.weather,
    required this.weatherLabel,
    required this.height,
    required this.level,
    required this.imageUrl,
  });

  final String title;
  final String slug;
  final String location;
  final String distance;
  final String rating;
  final String reviews;
  final String travelTime;
  final String status;
  final String weather;
  final String weatherLabel;
  final String height;
  final String level;
  final String imageUrl;
}

class _NearbyCategory {
  const _NearbyCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
