import 'package:flutter/material.dart';
import 'package:instagram_task_clone/model/user_model.dart';

import 'story_avatar.dart';

class StoryItem extends StatelessWidget {
  final bool isYourStory;
  final UserModel? user;

  const StoryItem({super.key, required this.isYourStory, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          StoryAvatar(isYourStory: isYourStory, imageUrl: user?.profileImage),
          const SizedBox(height: 6),
          SizedBox(
            width: 70,
            child: Text(
              isYourStory ? "Your story" : (user?.username ?? "username"),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}