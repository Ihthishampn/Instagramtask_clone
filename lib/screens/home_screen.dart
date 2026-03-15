import 'package:flutter/material.dart';
import 'package:instagram_task_clone/widgets/app_bar/ig_sliver_app_bar.dart';
import 'package:instagram_task_clone/widgets/posts_container/post/post_container.dart';
import 'package:instagram_task_clone/widgets/posts_container/post/post_container_skeleton.dart';
import 'package:instagram_task_clone/widgets/story_tray/stories_tray.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/providers/stories_provider.dart';
import 'package:instagram_task_clone/widgets/refresh/instagram_refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'package:instagram_task_clone/providers/navigation_provider.dart';
import 'package:instagram_task_clone/widgets/navigation/nav_bar.dart';
import 'package:instagram_task_clone/screens/tabs/placeholder_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isNearBottom = false;
  double? _lastMaxScrollExtent;
  final List<Widget> _pages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pages.isEmpty) {
      _pages.add(_buildFeedPage());
      _pages.add(const PlaceholderTab(title: 'Not completed'));
      _pages.add(const PlaceholderTab(title: 'Not completed'));
      _pages.add(const PlaceholderTab(title: 'Not completed'));
      _pages.add(const PlaceholderTab(title: 'Not completed'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (context, nav, _) {
          final idx = nav.currentIndex;
          final children = _pages.isNotEmpty
              ? _pages
              : [const SizedBox.shrink()];
          final safeIndex = (idx >= 0 && idx < children.length) ? idx : 0;

          return Scaffold(
            body: SafeArea(
              child: IndexedStack(index: safeIndex, children: children),
            ),
            bottomNavigationBar: const InstagramNavBar(),
          );
        },
      ),
    );
  }

  Widget _buildFeedPage() {
    return InstagramRefreshIndicator(
      onRefresh: () async {
        final feedProv = context.read<FeedProvider>();
        final storiesProv = context.read<StoriesProvider>();
        await feedProv.loadFeed();
        try {
          storiesProv.moveWatchedToEndAll();
        } catch (_) {}
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          final isNearBottom = metrics.pixels >= metrics.maxScrollExtent - 1500;

          final curMax = metrics.maxScrollExtent;
          if (_lastMaxScrollExtent == null) {
            _lastMaxScrollExtent = curMax;
          } else {
            final diff = (curMax - _lastMaxScrollExtent!).abs();
            if (diff > 0.5) {
              debugPrint(
                '[feed] maxScrollExtent changed by ${diff.toStringAsFixed(1)} '
                'during scroll. pixels=${metrics.pixels.toStringAsFixed(1)} '
                'viewport=${metrics.viewportDimension.toStringAsFixed(1)} '
                'min=${metrics.minScrollExtent.toStringAsFixed(1)}',
              );
              _lastMaxScrollExtent = curMax;
            }
          }

          if (isNearBottom != _isNearBottom) {
            _isNearBottom = isNearBottom;
            if (_isNearBottom) {
              debugPrint(
                '[HomeScreen] Scroll near bottom detected, loading more posts...',
              );
              try {
                context.read<FeedProvider>().loadMorePosts();
              } catch (e) {
                debugPrint('[HomeScreen] Error loading more: $e');
              }
            }
          }

          return false;
        },
        child: CustomScrollView(
          cacheExtent: 300,
          primary: true,
          slivers: [
            const IgSliverAppBar(),

            // story tab
            SliverToBoxAdapter(child: StoriesTray()),
            Consumer<FeedProvider>(
              builder: (context, feed, _) {
                if (feed.isLoading) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const PostContainerSkeleton(),
                      childCount: 5,
                      addAutomaticKeepAlives: false,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = feed.feedPosts[index];
                      return PostContainer(
                        key: ValueKey(post.post.id),
                        post: post,
                        index: index,
                      );
                    },
                    childCount: feed.feedPosts.length,
                    addAutomaticKeepAlives: false,
                    addSemanticIndexes: false,
                  ),
                );
              },
            ),
            Consumer<FeedProvider>(
              builder: (context, feed, _) {
                if (feed.isLoadingMore) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                if (!feed.hasMore) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'No more posts to show',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}
