import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/post_carousel_provider.dart';
import '../../../providers/feed_provider.dart';
import 'pinch_zoom_overlay.dart';


class PostCarousel extends StatefulWidget {
  final List<String> images;
  final int postIndex;

  const PostCarousel({
    super.key,
    required this.images,
    required this.postIndex,
  });

  @override
  State<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<PostCarousel> {
  PostCarouselProvider? _provider;
  PageController? _pageController;
  double? _lastScreenWidth;

  @override
  void initState() {
    super.initState();
    _provider = PostCarouselProvider(widget.images);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final initialPage = context.read<FeedProvider>().getCarouselPosition(
      widget.postIndex,
    );
    _pageController ??= PageController(initialPage: initialPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final w = MediaQuery.of(context).size.width;
        _lastScreenWidth = w;
        _provider?.ensureSizeFor(w);
      }
    });
  }

  @override
  void didUpdateWidget(covariant PostCarousel old) {
    super.didUpdateWidget(old);
    if (widget.images != old.images) {
      _provider?.dispose();
      _provider = PostCarouselProvider(widget.images);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final w = MediaQuery.of(context).size.width;
          _lastScreenWidth = w;
          _provider?.ensureSizeFor(w);
        }
      });
    }
  }

  @override
  void dispose() {
    _provider?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  Widget _buildImage(String url) {
    return PinchZoomOverlay(
      key: ValueKey('pinch_zoom_${widget.postIndex}_$url'),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.black),
        errorWidget: (context, url, error) => Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if ((screenWidth - (_lastScreenWidth ?? 0)).abs() > 10) {
      _lastScreenWidth = screenWidth;
   
    }

    if (_provider == null || _pageController == null) {
      return const SizedBox.shrink();
    }

    final height = screenWidth * 0.8;

    return SizedBox(
      height: height + (widget.images.length > 1 ? 40 : 0),
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: PageView.builder(
              controller: _pageController,
              physics: const _FeedFriendlyPagePhysics(),
              onPageChanged: (page) => context
                  .read<FeedProvider>()
                  .setCarouselPosition(widget.postIndex, page),
              itemCount: widget.images.length,
              itemBuilder: (context, index) => SizedBox(
                width: screenWidth,
                height: height,
                child: _buildImage(widget.images[index]),
              ),
            ),
          ),
          if (widget.images.length > 1)
            Consumer<FeedProvider>(
              builder: (context, feedProvider, _) {
                final cur = feedProvider.getCarouselPosition(widget.postIndex);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.images.length, (i) {
                      final active = cur == i;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: active ? 7 : 5,
                        height: active ? 7 : 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active
                              ? const Color(0xFF3897F0)
                              : Colors.grey.shade600,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}


class _FeedFriendlyPagePhysics extends PageScrollPhysics {
  const _FeedFriendlyPagePhysics()
    : super(parent: const ClampingScrollPhysics());

  @override
  _FeedFriendlyPagePhysics applyTo(ScrollPhysics? ancestor) =>
      const _FeedFriendlyPagePhysics();

  @override
  bool get allowImplicitScrolling => false;
}
