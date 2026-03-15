import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../shared/profile_placeholder.dart';

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
    final hasImage = imageUrl?.isNotEmpty ?? false;
    final showGradient = !isYourStory && !watched;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 88,
          height: 88,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: showGradient
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFEDA75),
                      Color(0xFFFA7E1E),
                      Color(0xFFD62976),
                      Color(0xFF962FBF),
                      Color(0xFF4F5BD5),
                    ],
                  )
                : null,
            color: (!showGradient && isYourStory) ? const Color(0xFF1A1A1A) : null,
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: SizedBox(
                width: 76,
                height: 76,
                child: !hasImage
                    ? Container(
                        color: const Color.fromARGB(255, 248, 248, 248),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Color.fromARGB(255, 122, 122, 126), 
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        width: 76,
                        height: 76,
                        placeholder: (context, url) => Container(
                          color: const Color(0xFF2C2C2E),
                          child: const Center(
                            child: ProfilePlaceholder(size: 48),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFF2C2C2E),
                          child: const Center(
                            child: ProfilePlaceholder(size: 48),
                          ),
                        ),
                      ),
              ),
            ),
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
                border: Border.all(
                  color: const Color(0xFF1A1A1A),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.add,
                size: 14,
                color: Colors.black,
              ),
            ),
          ),
      ],
    );
  }
}