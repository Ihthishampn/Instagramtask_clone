import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userThree() {
  return UserModel(
    id: 3,
    profileImage: "https://i.pinimg.com/736x/e1/f9/43/e1f9435da1048a60b800f4c71cc0b021.jpg",
    username: "Jaseel",
    posts: [

      PostModel(
        id: 9,
        location: "Kochi",
        image: [
          "https://i.pinimg.com/736x/0b/86/23/0b862310cc66749a77abf9f3b7e65cd4.jpg"
        ],
        caption:
            "Another productive day at the office. Small progress every day eventually leads to big results. Staying focused and disciplined is what keeps the journey moving forward.",
        hashTag: [
          "#dailygrind",
          "#careerfocus"
        ],
        shareCount: 1800,
        duration: Duration(hours: 1),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4200,
        likeCount: 11800,
        repostCount: 2600,
      ),

      PostModel(
        id: 10,
        location: "Calicut",
        image: [
          "https://i.pinimg.com/736x/5e/ca/16/5eca165b173c9cf5ffe289f8e76459bc.jpg",
          "https://i.pinimg.com/736x/6e/70/61/6e7061af88953764ecf846c587ce8064.jpg"
        ],
        caption:
            "Good friends and good conversations make the best memories. Moments like these remind me how important it is to pause and enjoy life.",
        hashTag: [
          "#friendsforever",
          "#weekendvibes"
        ],
        shareCount: 2300,
        duration: Duration(hours: 2),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 5100,
        likeCount: 16200,
        repostCount: 3200,
      ),

      PostModel(
        id: 11,
        location: "Kannur",
        image: [
          "https://i.pinimg.com/1200x/07/b2/28/07b228d584714794e4782690aa4e40e7.jpg",
          "https://i.pinimg.com/736x/ee/34/12/ee34121259b43d903170780038534a36.jpg",
        ],
        caption:
            "Traveling always gives a new perspective. Different places, new experiences, and memories that stay forever.",
        hashTag: [
          "#travelmoments",
          "#wanderlust",
        ],
        shareCount: 3100,
        duration: Duration(hours: 3),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 6300,
        likeCount: 19800,
        repostCount: 4100,
      ),

      PostModel(
        id: 12,
        location: "Malappuram",
        image: [
          "https://i.pinimg.com/736x/d5/69/df/d569dfd61cb24df711680a86d016ed00.jpg"
        ],
        caption:
            "A quiet tea break in the middle of a busy day. Sometimes the simplest moments are the most refreshing.",
        hashTag: [
          "#teatime",
          "#relaxbreak",
          "#calmvibes"
        ],
        shareCount: 1500,
        duration: Duration(hours: 4),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 3700,
        likeCount: 10400,
        repostCount: 1900,
      ),

      PostModel(
        id: 13,
        location: "Thrissur",
        image: [
                    "https://i.pinimg.com/736x/ed/3d/44/ed3d44871fe4d490217190ca8bbb8392.jpg"

          "https://i.pinimg.com/736x/33/e8/d5/33e8d5fb94544874e7cccc9a4de3cff0.jpg",
        ],
        caption:
            "Nothing beats a good meal after a long day. Food tastes better when shared with good company.",
        hashTag: [
          "#foodlover",
          "#lunchbreak",
          "#foodmoments",
        ],
        shareCount: 2600,
        duration: Duration(hours: 5),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 5800,
        likeCount: 17500,
        repostCount: 3500,
      ),

      PostModel(
        id: 14,
        location: "Kochi",
        image: [
          "https://i.pinimg.com/736x/8d/9a/92/8d9a9221251fd1b353852ab630bdf5ef.jpg"
        ],
        caption:
            "Late night coding session. Turning ideas into working features one line at a time.",
        hashTag: [
          "#developer",
          "#programming"
        ],
        shareCount: 4200,
        duration: Duration(hours: 6),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 7200,
        likeCount: 24300,
        repostCount: 5200,
      ),

      PostModel(
        id: 15,
        location: "Calicut",
        image: [
          "https://i.pinimg.com/736x/24/53/c1/2453c198d9c98b604adf488ded506f03.jpg"
        ],
        caption:
            "A calm night walk under the city lights. Quiet roads and cool air make the perfect ending to a long day.",
        hashTag: [
          "#nightwalk",
          "#peacefulnight",
        ],
        shareCount: 2100,
        duration: Duration(hours: 7),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4600,
        likeCount: 13800,
        repostCount: 2700,
      ),
    ],
  );
}