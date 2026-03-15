import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userTwo() {
  return UserModel(
    storyWacthed: false,
timeStoryPosted: Duration(seconds: 32),
  
    storyImage: "https://i.pinimg.com/736x/d9/7f/f4/d97ff473954db5a5fcb927e3d992de03.jpg",
    id: 2,
    profileImage: "https://i.pinimg.com/1200x/f3/d7/81/f3d781a2b7e4cd6f8f595b7a0c617e67.jpg",
    username: "Ihthisham",
    posts: [

      // POST 1
      PostModel(
        id: 5,
        location: "Kochi",
        image: [
          "https://i.pinimg.com/736x/1e/05/e3/1e05e3bf00379b97da0f71df0f8fab87.jpg",
          "https://i.pinimg.com/1200x/1a/dd/e3/1adde3b23ca4826fd034c1ebc87f6a1e.jpg"
        ],
        caption:
            "Started the day with an intense workout session. Every drop of sweat is a step closer to a stronger body and a disciplined mind. Consistency is the real secret behind progress.",
        hashTag: [
          "#fitnesslife",
          "#gymmotivation",
        ],
        shareCount: 2400,
        duration: Duration(hours: 2),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 5200,
        likeCount: 12400,
        repostCount: 3100,
      ),

      // POST 2
      PostModel(
        id: 6,
        location: "Thrissur",
        image: [
          "https://i.pinimg.com/1200x/bc/71/7a/bc717a995d7c6c46eb85aeeda55ed9dd.jpg"
        ],
        caption:
            "Nothing clears the mind like a long bike ride during the evening. The cool breeze, open roads, and peaceful moments make every ride feel like freedom.",
        hashTag: [
          "#bikelife",
          "#roadtripvibes"
        ],
        shareCount: 3100,
        duration: Duration(hours: 6),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 4300,
        likeCount: 15600,
        repostCount: 2700,
      ),

      // POST 3
      PostModel(
        id: 7,
        location: "Kannur",
        image: [
          "https://i.pinimg.com/736x/f8/34/dc/f834dc506f7fea871f7c47c54ecf4846.jpg",
          "https://i.pinimg.com/736x/3b/cc/6a/3bcc6a087b19893602ceba32b968df85.jpg",
        ],
        caption:
            "Spent the day at the beach watching the waves and enjoying the calm atmosphere. Moments like this remind me to slow down and appreciate nature.",
        hashTag: [
          "#beachday",
          "#oceanvibes",
          "#travelmoments"
        ],
        shareCount: 2800,
        duration: Duration(hours: 8),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 6100,
        likeCount: 17800,
        repostCount: 3400,
      ),

      // POST 4
      PostModel(
        id: 8,
        location: "Wayanad",
        image: [
          "https://i.pinimg.com/736x/82/0d/5f/820d5f79056469316e0bbe76134e70db.jpg",
          "https://i.pinimg.com/736x/13/a5/3f/13a53f454ec11d588353618c37421735.jpg"
        ],
        caption:
            "Surrounded by green hills and fresh air, Wayanad always feels like a peaceful escape from the busy world. Nature has a way of resetting the mind.",
        hashTag: [
          "#wayanad",
          "#mountainlife",
          "#travelkerala"
        ],
        shareCount: 3500,
        duration: Duration(hours: 10),
        isLiked: false,
        isReposted: false,
        isSaved: true,
        commentCount: 5400,
        likeCount: 20100,
        repostCount: 3900,
      ),
    ],
  );
}