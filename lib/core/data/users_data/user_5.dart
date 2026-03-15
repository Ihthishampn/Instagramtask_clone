import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userFive() {
  return UserModel(
    storyImage: "https://i.pinimg.com/736x/5c/4f/2a/5c4f2ae95431b6825a369635bd328466.jpg",
    id: 5,
    storyWacthed: false,
timeStoryPosted: Duration(hours: 8),

    profileImage: "https://i.pinimg.com/1200x/f0/2e/fd/f02efde7e43b32ace96cfa2edbaf002c.jpg",
    username: "Sinan",
    posts: [
      PostModel(
        id: 19,
        location: "Kochi",
        image: ["https://i.pinimg.com/736x/b1/db/a2/b1dba22098e35c6589075a68bcee7790.jpg", "https://i.pinimg.com/1200x/e0/83/e4/e083e4c3e7f5bf5086828d19ba2e0136.jpg"],
        caption:
            "Watching the sunset by the water is one of those moments that reminds you to slow down. The colors in the sky, the calm wind, and the quiet atmosphere make everything feel peaceful.",
        hashTag: ["#sunsetvibes", "#eveningview", "#naturemoment"],
        shareCount: 2400,
        duration: Duration(hours: 2),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4600,
        likeCount: 14300,
        repostCount: 3100,
      ),

      PostModel(
        id: 20,
        location: "Kannur",
        image: ["https://i.pinimg.com/736x/e6/d1/d6/e6d1d6056565e2cb1013ec7e3b845104.jpg"],
        caption:
            "A long bike ride on an open road clears the mind like nothing else. Just the sound of the engine and the feeling of freedom.",
        hashTag: ["#bikelife", "#roadride", "#freedomride"],
        shareCount: 1900,
        duration: Duration(hours: 3),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 3900,
        likeCount: 12100,
        repostCount: 2600,
      ),

      PostModel(
        id: 21,
        location: "Thrissur",
        image: ["https://i.pinimg.com/736x/0a/ed/8b/0aed8b51714fdb912f80b7a14b48d356.jpg", "https://i.pinimg.com/1200x/db/c2/cf/dbc2cf546e2a32fab810a31b5bcedd6c.jpg"],
        caption:
            "Starting the day with a good breakfast makes everything better. Good food and a calm morning set the mood for the whole day.",
        hashTag: ["#breakfasttime", "#foodmoment", "#morningstart"],
        shareCount: 3100,
        duration: Duration(hours: 4),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 5200,
        likeCount: 17600,
        repostCount: 3700,
      ),

      PostModel(
        id: 22,
        location: "Wayanad",
        image: ["https://i.pinimg.com/736x/83/42/c6/8342c666c3a16260a2150f3a08d0d9e0.jpg", "https://i.pinimg.com/736x/e6/83/8c/e6838cfdab8acd1d9d5c7175ca1ea44c.jpg"],
        caption:
            "Walking through the forest surrounded by trees and fresh air feels like a complete reset for the mind.",
        hashTag: ["#forestlife", "#naturewalk", "#greenworld"],
        shareCount: 2700,
        duration: Duration(hours: 5),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4800,
        likeCount: 15900,
        repostCount: 3300,
      ),

      PostModel(
        id: 23,
        location: "Malappuram",
        image: [ "https://i.pinimg.com/736x/1e/4e/84/1e4e847bbfeb0670a9a0fbeff3430464.jpg"],
        caption:
            "Good friends make ordinary days unforgettable. Simple conversations and laughs become the best memories.",
        hashTag: ["#friendstime", "#goodmoments", "#memories"],
        shareCount: 2200,
        duration: Duration(hours: 6),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4300,
        likeCount: 13700,
        repostCount: 2900,
      ),

      PostModel(
        id: 24,
        location: "Calicut",
        image: ["https://i.pinimg.com/736x/1b/78/38/1b78386b35f401227a892921e4483759.jpg"],
        caption:
            "A warm cup of coffee and a quiet moment can fix almost anything.",
        hashTag: ["#coffeetime", "#cafelife", "#relaxmoment"],
        shareCount: 1600,
        duration: Duration(hours: 7),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 3500,
        likeCount: 10800,
        repostCount: 2100,
      ),
    ],
  );
}