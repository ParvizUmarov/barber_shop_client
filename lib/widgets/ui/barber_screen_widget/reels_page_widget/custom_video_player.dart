import 'package:barber_shop/widgets/ui/barber_screen_widget/reels_page_widget/post_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CustomVideoPlayer extends StatefulWidget {
  final Post post;

  const CustomVideoPlayer({super.key, required this.post});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.asset(widget.post.assetPath);
    videoPlayerController.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(videoPlayerController.dataSource),
      onVisibilityChanged: (info) {
        if(info.visibleFraction > 0.5){
          videoPlayerController.play();
        }else{
          if(mounted){
            videoPlayerController.pause();
          }

        }
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (videoPlayerController.value.isPlaying) {
              videoPlayerController.pause();
            } else {
              videoPlayerController.play();
            }
          });
        },
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.2, 0.8, 1.0]),
                  ),
                ),
              ),
              _BuildVideoActions(videoPlayerController: videoPlayerController),
              _BuildVideoCaptions(widget: widget),

            ],
          ),
        ),
      ),
    );
  }
}

class _BuildVideoActions extends StatelessWidget {
  const _BuildVideoActions({
    super.key,
    required this.videoPlayerController,
  });

  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: videoPlayerController.value.size.height,
        width: MediaQuery.of(context).size.width * 0.2,
        padding: const EdgeInsets.only(bottom: 20),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const[
            _VideoActions(icon: Icons.favorite, value: '11.4k',),
            SizedBox(height: 10),
            _VideoActions(icon: Icons.comment, value: '1.4k',),
            SizedBox(height: 10),
            _VideoActions(icon: Icons.send, value: '420',),

          ],
        ),
      ),
    );
  }
}

class _VideoActions extends StatelessWidget {
  final IconData icon;
  final String value;

  const _VideoActions({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.black54,
              shape: CircleBorder(),
            ),
            child: IconButton(
              color: Colors.white,
                onPressed: (){},
                icon: Icon(icon),),
          ),
        ),
        Text(value,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold
          ),)
      ],
    );
  }
}

class _BuildVideoCaptions extends StatelessWidget {
  const _BuildVideoCaptions({
    super.key,
    required this.widget,
  });

  final CustomVideoPlayer widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 125 ,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.post.caption,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
