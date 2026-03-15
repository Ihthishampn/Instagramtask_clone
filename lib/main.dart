import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_task_clone/core/theme/theme.dart';
import 'package:instagram_task_clone/providers/stories_provider.dart';
import 'package:instagram_task_clone/providers/feed_provider.dart';
import 'package:instagram_task_clone/repositories/post_repository.dart';
import 'package:instagram_task_clone/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
 
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(220, 32, 32, 34),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StoriesProvider(PostRepository())..loadStories(),
        ),
        ChangeNotifierProvider(
          create: (_) => FeedProvider(PostRepository())..loadFeed(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const HomeScreen(),
      ),
    );
  }
}
