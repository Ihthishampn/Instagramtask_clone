import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'story_constants.dart';

class StoryHeader extends StatelessWidget {
  final Animation<double> progressAnimation;
  final dynamic currentUser;
  final String Function(Duration) formatTime;

  const StoryHeader({
    super.key,
    required this.progressAnimation,
    required this.currentUser,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
            child: SizedBox(
              height: progressBarHeight,
              child: AnimatedBuilder(
                animation: progressAnimation,
                builder: (context, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: progressAnimation.value,
                      minHeight: progressBarHeight,
                      backgroundColor: Colors.white.withOpacity(0.25),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: currentUser.profileImage,
                      fit: BoxFit.cover,
                      errorWidget: (c, u, e) => Container(
                        color: Colors.grey,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            currentUser.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            formatTime(currentUser.timeStoryPosted),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'AI info',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.more_vert, color: Colors.white, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
