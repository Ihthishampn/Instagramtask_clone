import 'package:flutter/material.dart';
import 'package:instagram_task_clone/core/constants/image.dart';
import 'package:instagram_task_clone/core/constants/my_colors.dart';
import 'package:instagram_task_clone/widgets/app_bar/my_icon_button.dart';
import 'package:instagram_task_clone/widgets/posts_container/post_container.dart';
import 'package:instagram_task_clone/widgets/posts_container/post_container_skeleton.dart';
import 'package:instagram_task_clone/widgets/story_tray/stories_tray.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/model/feed_post_model.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _isNearBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isNearBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 600;

    if (isNearBottom != _isNearBottom) {
      _isNearBottom = isNearBottom;
      if (_isNearBottom) {
        context.read<FeedProvider>().loadMorePosts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provide a local NavigationProvider for bottom tabs.
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (context, nav, _) {
          final idx = nav.currentIndex;
          return Scaffold(
            body: SafeArea(child: _buildBodyForIndex(context, idx)),
            bottomNavigationBar: const InstagramNavBar(),
          );
        },
      ),
    );
  }

  Widget _buildBodyForIndex(BuildContext context, int idx) {
    if (idx != 0) {
      return const PlaceholderTab(title: 'Not completed');
    }

    final double width = MediaQuery.of(context).size.width;
    return InstagramRefreshIndicator(
      onRefresh: () async {
        await context.read<FeedProvider>().loadFeed();
      },
      child: CustomScrollView(
        controller: _scrollController,
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
        ],
      ),
    );
  }
}
