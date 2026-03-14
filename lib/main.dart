import 'package:flutter/material.dart';
import 'package:instagram_task_clone/core/theme/theme.dart';
import 'package:instagram_task_clone/providers/stories_provider.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/repositories/post_repository.dart';
import 'package:instagram_task_clone/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => StoriesProvider(PostRepository())..loadStories(),
          ),
          ChangeNotifierProvider(
            create: (_) => FeedProvider(PostRepository())..loadFeed(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
