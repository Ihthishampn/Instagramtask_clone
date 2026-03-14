import 'package:flutter/material.dart';
import 'package:instagram_task_clone/model/feed_post_model.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/providers/toggle_change_provider.dart';
import 'package:provider/provider.dart';

import 'post_action_row.dart';
import 'post_carousel.dart';
import 'post_details.dart';
import 'post_header.dart';

class PostContainer extends StatefulWidget {
  final int index;
  final FeedPost post;

  const PostContainer({super.key, required this.index, required this.post});

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer>
    with TickerProviderStateMixin {
  late AnimationController _heartAnimationController;
  late Animation<double> _heartScaleAnimation;
  late Animation<double> _heartOpacityAnimation;

  @override
  void initState() {
    super.initState();
    // Removed verbose init logging to avoid jank during fast scrolling.
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _heartScaleAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _heartOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    context.read<FeedProvider>().likePost(widget.index);

    _heartAnimationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ToggleChangeProvider()
            ..setAnimationController(_heartAnimationController),
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PostHeader(
              username: widget.post.user.username,
              profileImageUrl: widget.post.user.profileImage,
              location: widget.post.post.location,
              onMoreTap: () {},
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onDoubleTap: _handleDoubleTap,
                  child: PostCarousel(
                    images: widget.post.post.image,
                    postIndex: widget.index,
                  ),
                ),
                Consumer<ToggleChangeProvider>(
                  builder: (context, toggleProvider, _) {
                    return AnimatedBuilder(
                      animation: _heartAnimationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _heartOpacityAnimation.value,
                          child: RepaintBoundary(
                            child: Transform.scale(
                              scale: _heartScaleAnimation.value,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 100,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            PostActionRow(post: widget.post, index: widget.index),
            PostDetails(post: widget.post),
          ],
        ),
      ),
    );
  }
}
