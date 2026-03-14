import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryAvatar extends StatelessWidget {
  final bool isYourStory;
  final String? imageUrl;

  const StoryAvatar({super.key, required this.isYourStory, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final hasImage = (imageUrl?.isNotEmpty ?? false);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isYourStory
                ? null
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFEDA75),
                      Color(0xFFFA7E1E),
                      Color(0xFFD62976),
                      Color(0xFF962FBF),
                      Color(0xFF4F5BD5),
                    ],
                  ),
          ),
          child: CircleAvatar(
            radius: 33,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: !hasImage
                    ? const Icon(Icons.person, color: Colors.grey, size: 35)
                    : CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[800]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white,
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
              ),
            ),
          ),
        ),

        if (isYourStory)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.add, size: 14, color: Colors.black),
            ),
          ),
      ],
    );
  }
}
