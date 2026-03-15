import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/stories_provider.dart';
import '../shared/ui_helpers.dart';
import 'story_image.dart';
import 'story_header.dart';
import 'story_footer.dart';
import 'story_touch_zones.dart';

class StoryViewer extends StatefulWidget {
  final int startIndex;

  const StoryViewer({super.key, required this.startIndex});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  static const Duration _storyDuration = Duration(seconds: 5);

  int _currentIndex = 0;
  DateTime? _touchStart;
  static const Duration _tapThreshold = Duration(milliseconds: 180);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _pageController = PageController(initialPage: widget.startIndex);
    _progressController =
        AnimationController(vsync: this, duration: _storyDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _advanceToNext();
            }
          });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prov = Provider.of<StoriesProvider>(context, listen: false);
      prov.markWatched(_currentIndex);
      _progressController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _advanceToNext() {
    final prov = Provider.of<StoriesProvider>(context, listen: false);
    final users = prov.users;
    if (_currentIndex < users.length - 1) {
      final next = _currentIndex + 1;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      prov.moveWatchedToEndAll();
      Navigator.of(context).pop();
    }
  }

  void _goToPrev() {
    if (_currentIndex > 0) {
      final prev = _currentIndex - 1;
      _pageController.animateToPage(
        prev,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _pauseProgress() {
    try {
      _progressController.stop();
    } catch (_) {}
  }

  void _resumeProgress() {
    try {
      if (_progressController.isAnimating) return;
      _progressController.forward();
    } catch (_) {}
  }

  void _handleTouchDown() {
    _touchStart = DateTime.now();
    _pauseProgress();
  }

  void _handleTouchCancel() {
    _touchStart = null;
    _resumeProgress();
  }

  void _handleLeftTapUp() {
    final start = _touchStart;
    _touchStart = null;
    final elapsed = start == null
        ? Duration.zero
        : DateTime.now().difference(start);
    _resumeProgress();
    if (elapsed < _tapThreshold) {
      _goToPrev();
    }
  }

  void _handleRightTapUp() {
    final start = _touchStart;
    _touchStart = null;
    final elapsed = start == null
        ? Duration.zero
        : DateTime.now().difference(start);
    _resumeProgress();
    if (elapsed < _tapThreshold) {
      _advanceToNext();
    }
  }

  String _formatTime(Duration d) {
    if (d.inDays > 0) return '${d.inDays}d';
    if (d.inHours > 0) return '${d.inHours}h';
    if (d.inMinutes > 0) return '${d.inMinutes}m';
    return 'now';
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final prov = Provider.of<StoriesProvider>(context);
    final users = prov.users;

    if (prov.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (users.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text('No stories', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    final currentUser = users[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: users.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (idx) {
              setState(() => _currentIndex = idx);
              prov.markWatched(idx);
              _progressController.stop();
              _progressController.reset();
              _progressController.forward();
            },
            itemBuilder: (context, index) {
              final u = users[index];
              // compute height so the image bottom aligns with the top of the action bar
              final availableHeight = computeAvailableHeight(mq);

              return StoryImage(
                imageUrl: u.storyImage,
                availableHeight: availableHeight,
                topPadding: mq.padding.top,
              );
            },
          ),

          StoryTouchZones(
            onTouchDown: _handleTouchDown,
            onLeftTapUp: _handleLeftTapUp,
            onRightTapUp: _handleRightTapUp,
            onTapCancel: _handleTouchCancel,
          ),

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

          StoryHeader(
            progressAnimation: _progressController,
            currentUser: currentUser,
            formatTime: _formatTime,
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
