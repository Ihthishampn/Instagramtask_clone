import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userFour() {
  return UserModel(
    storyImage: "https://i.pinimg.com/1200x/88/71/eb/8871ebad969183b596f8f49ba6d39adf.jpg",
    id: 4,
    storyWacthed: false,
timeStoryPosted: Duration(hours: 7),
    profileImage: "https://i.pinimg.com/1200x/35/4c/3c/354c3c84ead2f818f5222faa847fd2e7.jpg",
    username: "Ajwad",
    posts: [

      PostModel(
        id: 16,
        location: "Calicut",
        image: ["https://i.pinimg.com/736x/0f/37/27/0f37272aec37162734e1c5e3b1bfbfa5.jpg", "https://i.pinimg.com/736x/b3/89/24/b3892412f8104889b17a9ff9505f1a9e.jpg", "https://i.pinimg.com/736x/8e/86/e5/8e86e575cb2ed4aa3b10adee59171b18.jpg"],
        caption:
            "Nothing beats the energy of a good football match. The sound of the crowd, the fast pace of the game, and the excitement of every goal make football more than just a sport. It's passion, teamwork, and pure adrenaline.",
        hashTag: [
          "#footballlife",
          "#gameday",
        ],
        shareCount: 2100,
        duration: Duration(hours: 3),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 6400,
        likeCount: 18200,
        repostCount: 3900,
      ),

      PostModel(
        id: 17,
        location: "Kochi",
        image: ["https://i.pinimg.com/736x/13/f0/8b/13f08b6a098943536388763e958c1684.jpg", "https://i.pinimg.com/1200x/6e/eb/90/6eeb90b968357d28c943477ce737d45e.jpg"],
        caption:
            "City lights, busy streets, and endless movement. Every city has its own rhythm, and sometimes the best thing to do is just pause for a moment and enjoy the view.",
        hashTag: [
          "#cityview",
          "#urbanlife",
          "#citylights",
        ],
        shareCount: 1600,
        duration: Duration(hours: 4),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4200,
        likeCount: 12500,
        repostCount: 2700,
      ),

      PostModel(
        id: 18,
        location: "Malappuram",
        image: ["https://i.pinimg.com/1200x/ba/36/35/ba36358818d9451fd22ce52c3ba43183.jpg"],
        caption:
            "Sometimes the best plan is no plan at all. Just relaxing, enjoying the moment, and letting the day go slowly. These simple moments are often the most peaceful ones.",
        hashTag: [
          "#relaxmode",
          "#chilltime",
          "#peacefulmoment"
        ],
        shareCount: 1300,
        duration: Duration(hours: 6),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 3500,
        likeCount: 10900,
        repostCount: 2100,
      ),
    ],
  );
}