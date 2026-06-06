import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/location_model.dart';
import 'featured_destination_card.dart';

class FeaturedDestinationCarousel extends StatefulWidget {
  const FeaturedDestinationCarousel({super.key, required this.locations});

  final List<LocationModel> locations;

  @override
  State<FeaturedDestinationCarousel> createState() =>
      _FeaturedDestinationCarouselState();
}

class _FeaturedDestinationCarouselState
    extends State<FeaturedDestinationCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1.0);
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
          height: 280,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.locations.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FeaturedDestinationCard(
                location: widget.locations[index],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.locations.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 3.5),
              width: isActive ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: isActive
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
