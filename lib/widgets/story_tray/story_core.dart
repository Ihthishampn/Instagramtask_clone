import 'package:flutter/material.dart';

import 'package:instagram_task_clone/model/user_model.dart';
import '../../core/shared/ui_helpers.dart';
import 'story_image.dart';
import 'story_header.dart';
import 'story_footer.dart';
import 'story_touch_zones.dart';

class StoryCore extends StatelessWidget {
  final PageController pageController;
  final AnimationController progressController;
  final List<UserModel> users;
  final int currentIndex;
  final VoidCallback onAdvanceToNext;
  final VoidCallback onGoToPrev;
  final VoidCallback onTouchDown;
  final VoidCallback onTouchCancel;
  final VoidCallback onLeftTapUp;
  final VoidCallback onRightTapUp;
  final ValueChanged<int> onPageChanged;

  const StoryCore({
    super.key,
    required this.pageController,
    required this.progressController,
    required this.users,
    required this.currentIndex,
    required this.onAdvanceToNext,
    required this.onGoToPrev,
    required this.onTouchDown,
    required this.onTouchCancel,
    required this.onLeftTapUp,
    required this.onRightTapUp,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: users.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (idx) {
              onPageChanged(idx);
            },
            itemBuilder: (context, index) {
              final u = users[index];
              final availableHeight = computeAvailableHeight(mq);
              return StoryImage(
                imageUrl: u.storyImage,
                availableHeight: availableHeight,
                topPadding: mq.padding.top,
              );
            },
          ),

          StoryTouchZones(
            onTouchDown: onTouchDown,
            onLeftTapUp: onLeftTapUp,
            onRightTapUp: onRightTapUp,
            onTapCancel: onTouchCancel,
          ),

          const _StoryGradients(),

          StoryHeader(
            progressAnimation: progressController,
            currentUser: users[currentIndex],
            formatTime: (d) => formatRelativeTime(d),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: StoryFooter(mq: mq, onSend: null),
          ),
        ],
      ),
    );
  }
}

class _StoryGradients extends StatelessWidget {
  const _StoryGradients();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.55), Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 160,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.55), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
