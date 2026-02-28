import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../data/banner_model.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (widget.banners.length > 1) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_currentPage + 1) % widget.banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  child: AppNetworkImage(
                          imageUrl: banner.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 170,
                          errorWidget: Container(
                            color: AppColors.primarySurface,
                            child: Center(
                              child: Text(
                                banner.title ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        if (widget.banners.length > 1) ...[
          const SizedBox(height: AppDimens.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.banners.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentPage == i ? 20 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: _currentPage == i
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
