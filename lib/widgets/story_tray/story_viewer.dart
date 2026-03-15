import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/stories_provider.dart';
import '../../providers/story_viewer_provider.dart';
import 'story_core.dart';

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
  static const Duration _storyDuration = Duration(seconds: 8);

  late StoryViewerProvider _viewerProv;
  DateTime? _touchStart;
  static const Duration _tapThreshold = Duration(milliseconds: 180);

  @override
  void initState() {
    super.initState();
    _viewerProv = StoryViewerProvider(widget.startIndex);
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
      prov.markWatched(_viewerProv.currentIndex);
      _progressController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    try {
      _viewerProv.dispose();
    } catch (_) {}
    super.dispose();
  }

  void _advanceToNext() {
    final prov = Provider.of<StoriesProvider>(context, listen: false);
    final users = prov.users;
    if (_viewerProv.currentIndex < users.length - 1) {
      final next = _viewerProv.currentIndex + 1;
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
    if (_viewerProv.currentIndex > 0) {
      final prev = _viewerProv.currentIndex - 1;
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

  @override
  Widget build(BuildContext context) {
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

    return ChangeNotifierProvider.value(
      value: _viewerProv,
      child: StoryCore(
        pageController: _pageController,
        progressController: _progressController,
        users: users,
        currentIndex: _viewerProv.currentIndex,
        onAdvanceToNext: _advanceToNext,
        onGoToPrev: _goToPrev,
        onTouchDown: _handleTouchDown,
        onTouchCancel: _handleTouchCancel,
        onLeftTapUp: _handleLeftTapUp,
        onRightTapUp: _handleRightTapUp,
        onPageChanged: (idx) {
          _viewerProv.setCurrentIndex(idx);
          final prov = Provider.of<StoriesProvider>(context, listen: false);
          prov.markWatched(idx);
          try {
            _progressController.stop();
          } catch (_) {}
          try {
            _progressController.reset();
          } catch (_) {}
          try {
            _progressController.forward(from: 0);
          } catch (_) {}
        },
      ),
    );
  }
}
