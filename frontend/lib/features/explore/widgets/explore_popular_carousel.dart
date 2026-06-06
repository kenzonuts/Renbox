import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/location_model.dart';
import 'explore_popular_card.dart';

class ExplorePopularCarousel extends StatefulWidget {
  const ExplorePopularCarousel({super.key, required this.locations});

  final List<LocationModel> locations;

  @override
  State<ExplorePopularCarousel> createState() => _ExplorePopularCarouselState();
}

class _ExplorePopularCarouselState extends State<ExplorePopularCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locations.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.locations.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ExplorePopularCard(location: widget.locations[i]),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.locations.length, (index) {
            final active = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 3.5),
              width: active ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: active
                    ? AppColors.forestGreen
                    : AppColors.stone.withValues(alpha: 0.9),
              ),
            );
          }),
        ),
      ],
    );
  }
}
