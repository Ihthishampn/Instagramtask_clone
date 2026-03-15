import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram_task_clone/widgets/refresh/instagram_refresh_indicator.dart';
import 'package:instagram_task_clone/widgets/app_bar/my_icon_button.dart';
import 'package:instagram_task_clone/core/constants/image.dart';
import 'package:instagram_task_clone/core/constants/my_colors.dart';
import 'package:instagram_task_clone/widgets/story_tray/stories_tray.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/providers/stories_provider.dart';
import 'package:instagram_task_clone/widgets/posts_container/post/post_container.dart';
import 'package:instagram_task_clone/widgets/posts_container/post/post_container_skeleton.dart';
import 'package:instagram_task_clone/model/feed_post_model.dart';

class FeedTab extends StatefulWidget {
  const FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> with AutomaticKeepAliveClientMixin {
  bool _isNearBottom = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double width = MediaQuery.of(context).size.width;

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
          final isNearBottom = metrics.pixels >= metrics.maxScrollExtent - 600;

          if (isNearBottom != _isNearBottom) {
            _isNearBottom = isNearBottom;
            if (_isNearBottom) {
              try {
                context.read<FeedProvider>().loadMorePosts();
              } catch (_) {}
            }
          }

          return false;
        },
        child: CustomScrollView(
          primary: true,
          slivers: [
            SliverAppBar(
              leading: MyIconButton(onpressed: () {}, icon: Icons.add),
              centerTitle: true,
              title: Image.asset(
                logoImage,
                color: MyColors.logo,
                width: (width * 0.35).clamp(100, 200),
              ),
              actions: [
                MyIconButton(
                  onpressed: () {},
                  icon: Icons.favorite_border_outlined,
                ),
              ],
            ),

            // story tab
            SliverToBoxAdapter(child: StoriesTray()),
            Selector<FeedProvider, List<FeedPost>>(
              selector: (context, feed) => feed.feedPosts,
              builder: (context, feedPosts, _) {
                final feed = context.read<FeedProvider>();
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
