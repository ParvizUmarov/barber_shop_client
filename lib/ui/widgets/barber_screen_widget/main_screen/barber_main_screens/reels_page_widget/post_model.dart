enum PostType{ image, video, audio}

class Post{
  final String id;
  final PostType type;
  final String caption;
  final String assetPath;

  Post({
    required this.id,
    required this.type,
    required this.caption,
    required this.assetPath
});


  static List<Post> posts = [
    Post(
        id: '1',
        type: PostType.video,
        caption: "Тренды мужских стрижек 2023",
        assetPath: 'assets/videos/firstContent.mp4'
  ),
    Post(
        id: '2',
        type: PostType.video,
        caption: "Спортивная стрижка боксполубокс",
        assetPath: 'assets/videos/secondContent.mp4'
  ),
    Post(
        id: '3',
        type: PostType.video,
        caption: "Кроп мужская стрижка",
        assetPath: 'assets/videos/thirdContent.mp4'
  ), Post(
        id: '4',
        type: PostType.video,
        caption: "Самая популярная мужская стрижка",
        assetPath: 'assets/videos/fourthContent.mp4'
  ),

  ];

  List<Post> get listOfPosts => posts;

}