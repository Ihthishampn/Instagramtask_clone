import 'package:flutter/material.dart';
import 'package:instagram_task_clone/model/user_model.dart';
import 'package:provider/provider.dart';

import 'story_avatar.dart';
import '../../providers/stories_provider.dart';
import 'story_viewer.dart';

class StoryItem extends StatelessWidget {
  final bool isYourStory;
  final UserModel? user;

  const StoryItem({super.key, required this.isYourStory, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          if (isYourStory) return;
          final provider = Provider.of<StoriesProvider>(context, listen: false);
          final users = provider.users;
          final startIndex = users.indexWhere((u) => u.id == user?.id);
          if (startIndex == -1) return;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StoryViewer(startIndex: startIndex),
            ),
          );
        },
        child: Column(
          children: [
            StoryAvatar(
              isYourStory: isYourStory,
              imageUrl: user?.profileImage,
              watched: user?.storyWacthed ?? false,
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 78,
              child: Text(
                isYourStory ? "Your story" : (user?.username ?? "username"),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
