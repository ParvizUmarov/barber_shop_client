import 'package:flutter/material.dart';

import 'custom_video_player.dart';
import 'post_model.dart';

class BarberReelsPageWidget extends StatefulWidget {
  const BarberReelsPageWidget({super.key});

  @override
  State<BarberReelsPageWidget> createState() => _BarberReelsPageWidgetState();
}

class _BarberReelsPageWidgetState extends State<BarberReelsPageWidget> {
  @override
  Widget build(BuildContext context) {
    List<Post> posts = Post.posts;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: posts.map((post) {
            return CustomVideoPlayer(post: post,);
          }).toList(),
        ),
      ),
    );
  }
}
