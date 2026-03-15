import 'package:flutter/material.dart';
import '../../widgets/shared/avatar_image.dart';
import '../../widgets/shared/ring_decoration.dart';

class StoryAvatar extends StatelessWidget {
  final bool isYourStory;
  final String? imageUrl;
  final bool watched;

  const StoryAvatar({
    super.key,
    required this.isYourStory,
    this.imageUrl,
    this.watched = false,
  });

  @override
  Widget build(BuildContext context) {
    final showGradient = !isYourStory && !watched;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        RingDecoration(
          outerSize: 88,
          padding: 3,
          showGradient: showGradient,
          isYourStory: isYourStory,
          child: AvatarImage(
            width: 76,
            height: 76,
            imageUrl: imageUrl,
            placeholderSize: 48,
          ),
        ),
        if (isYourStory)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
              ),
              child: const Icon(Icons.add, size: 14, color: Colors.black),
            ),
          ),
      ],
    );
  }
}
