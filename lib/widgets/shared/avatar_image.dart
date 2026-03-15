import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/shared/profile_placeholder.dart';
import '../../core/cache/custom_cache_manager.dart';

class AvatarImage extends StatelessWidget {
  final double width;
  final double height;
  final String? imageUrl;
  final double placeholderSize;

  const AvatarImage({
    super.key,
    required this.width,
    required this.height,
    this.imageUrl,
    required this.placeholderSize,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl?.isNotEmpty ?? false;
    return ClipOval(
      child: SizedBox(
        width: width,
        height: height,
        child: !hasImage
            ? Container(
                color: const Color.fromARGB(255, 248, 248, 248),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: placeholderSize,
                    color: const Color.fromARGB(255, 122, 122, 126),
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                cacheManager: AppCacheManager.instance,
                fit: BoxFit.cover,
                width: width,
                height: height,
                placeholder: (context, url) => Container(
                  color: const Color(0xFF2C2C2E),
                  child: Center(
                    child: ProfilePlaceholder(size: placeholderSize),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFF2C2C2E),
                  child: Center(
                    child: ProfilePlaceholder(size: placeholderSize),
                  ),
                ),
              ),
      ),
    );
  }
}
