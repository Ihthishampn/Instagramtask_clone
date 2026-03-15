import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'story_constants.dart';

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
              placeholder: (c, url) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
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
