class PostModel {
  final int id;
  final String location;
  final List<String> image;
  final String caption;
  final List<String> hashTag;
  final Duration duration;
  final num likeCount;
  final num commentCount;
  final num repostCount;
  final num shareCount;


  bool isLiked;
  bool isSaved;
  bool isReposted;

  PostModel({
    required this.id,
    required this.location,
    required this.image,
    required this.caption,
    required this.hashTag,
    required this.shareCount,
    required this.duration,
    required this.isLiked,
    required this.isReposted,
    required this.isSaved,
    required this.commentCount,
    required this.likeCount,
    required this.repostCount,
  });
}
