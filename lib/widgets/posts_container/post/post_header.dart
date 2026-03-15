import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../../../core/cache/custom_cache_manager.dart';

import '../../../providers/stories_provider.dart';
import '../../../core/shared/profile_placeholder.dart';
import '../../story_tray/story_viewer.dart';
import '../../shared/ring_decoration.dart';
import 'post_more_sheet.dart';

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
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade900,
            highlightColor: Colors.grey.shade700,
            child: Container(color: Colors.black),
          );
        }
        return Container(color: Colors.black);
      },
    );
  }
}

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
                child: RingDecoration(
                  outerSize: 42,
                  padding: 2,
                  showGradient: showStoryRing,
                  isYourStory: false,
                  child: ClipOval(
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: CachedNetworkImage(
                        imageUrl: profileImageUrl,
                        cacheManager: AppCacheManager.instance,
                        fit: BoxFit.cover,
                        width: 34,
                        height: 34,
                        placeholder: (context, url) =>
                            _DelayedShimmerPlaceholder(
                              delay: const Duration(seconds: 2),
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
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const PostMoreSheet(),
              );
              if (onMoreTap != null) onMoreTap!();
            },
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
