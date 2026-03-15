import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

import '../../providers/stories_provider.dart';
import '../shared/profile_placeholder.dart';
import '../story_tray/story_viewer.dart';

class PostHeader extends StatelessWidget {
  final int userId;
  final String username;
  final String profileImageUrl;
  final String location;
  final VoidCallback? onMoreTap;

  const PostHeader({
    super.key,
    required this.userId,
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
          // Avatar with optional story ring (gradient when unwatched)
          Builder(
            builder: (context) {
              final hasWatched = context.select<StoriesProvider, bool>(
                (prov) =>
                    prov.users.any((u) => u.id == userId && u.storyWacthed),
              );
              final showStoryRing = !hasWatched;

              return GestureDetector(
                onTap: showStoryRing
                    ? () {
                        final prov = Provider.of<StoriesProvider>(
                          context,
                          listen: false,
                        );
                        final idx = prov.users.indexWhere(
                          (u) => u.id == userId,
                        );
                        if (idx != -1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => StoryViewer(startIndex: idx),
                            ),
                          );
                        }
                      }
                    : null,
                child: Container(
                  width: 42,
                  height: 42,
                  // outer gradient ring (thinner than default)
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: showStoryRing
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
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
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
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: ProfilePlaceholder(size: 22),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
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
