import 'package:flutter/material.dart';
import 'package:instagram_task_clone/model/feed_post_model.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/widgets/posts_container/post/post_container_actions.dart';
import 'package:provider/provider.dart';

class PostActionRow extends StatelessWidget {
  final FeedPost post;
  final int index;

  const PostActionRow({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          Consumer<FeedProvider>(
            builder: (context, feed, _) {
              final postData = post.post;
              return ActionIcon(
                icon: postData.isLiked ? Icons.favorite : Icons.favorite_border,
                color: postData.isLiked ? Colors.red : Colors.white,
                count: postData.likeCount + (postData.isLiked ? 1 : 0),
                onTap: () => feed.toggleLike(index),
              );
            },
          ),
          const SizedBox(width: 16),
          ActionIcon(
            icon: Icons.chat_bubble_outline_rounded,
            count: post.post.commentCount,
            onTap: () {},
          ),
          const SizedBox(width: 16),
          ActionIcon(
            icon: Icons.repeat,
            count: post.post.repostCount,
            onTap: () {},
          ),
          const SizedBox(width: 16),
          ActionIcon(
            icon: Icons.send_rounded,
            count: post.post.shareCount,
            onTap: () {},
            rotateAngle: -0.7,
          ),
          const Spacer(),
          Consumer<FeedProvider>(
            builder: (context, feed, _) {
              final postData = post.post;
              return IGIconButton(
                icon: postData.isSaved ? Icons.bookmark : Icons.bookmark_border,

                color: Colors.white,
                onTap: () => feed.toggleSave(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
