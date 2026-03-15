import 'package:flutter/material.dart';
import 'package:instagram_task_clone/providers/stories_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'story_item.dart';

class StoriesTray extends StatelessWidget {
  const StoriesTray({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 111,
      child: Consumer<StoriesProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return _StoriesShimmer();
          }

          final users = provider.users;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length + 1,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const StoryItem(isYourStory: true);
              }

              final user = users[index - 1];
              return StoryItem(isYourStory: false, user: user);
            },
          );
        },
      ),
    );
  }
}

class _StoriesShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade700,
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade700,
                child: Container(width: 76, height: 11, color: Colors.white),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 0),
      itemCount: 8,
    );
  }
}
