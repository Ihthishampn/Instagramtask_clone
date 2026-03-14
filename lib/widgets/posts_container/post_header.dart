import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String profileImageUrl;
  final String location;
  final VoidCallback? onMoreTap;

  const PostHeader({
    super.key,
    required this.username,
    required this.profileImageUrl,
    required this.location,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          // Avatar with story ring
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xFF262626),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: profileImageUrl,
                    fit: BoxFit.cover,
                    width: 34,
                    height: 34,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade900,
                      highlightColor: Colors.grey.shade700,
                      child: Container(color: Colors.black),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified,
                      color: Color(0xFF3897F0),
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  location,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onMoreTap,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.more_vert, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
