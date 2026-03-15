import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'story_constants.dart';

class _DelayedShimmerPlaceholder extends StatefulWidget {
  final Duration delay;

  const _DelayedShimmerPlaceholder({required this.delay});

  @override
  State<_DelayedShimmerPlaceholder> createState() =>
      _DelayedShimmerPlaceholderState();
}

class _DelayedShimmerPlaceholderState
    extends State<_DelayedShimmerPlaceholder> {
  late Future<void> _delayFuture;

  @override
  void initState() {
    super.initState();
    _delayFuture = Future.delayed(widget.delay);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _delayFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            color: Colors.grey[900],
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        return Container(color: Colors.grey[900]);
      },
    );
  }
}

class StoryImage extends StatelessWidget {
  final String imageUrl;
  final double availableHeight;
  final double topPadding;

  const StoryImage({
    super.key,
    required this.imageUrl,
    required this.availableHeight,
    required this.topPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: availableHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(imageBorderRadius),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              placeholder: (c, url) =>
                  _DelayedShimmerPlaceholder(delay: const Duration(seconds: 2)),
              errorWidget: (c, url, e) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
