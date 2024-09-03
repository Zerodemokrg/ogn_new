import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<ui.PointerDeviceKind> get dragDevices => {
    ui.PointerDeviceKind.touch,
    ui.PointerDeviceKind.mouse,
    // etc.
  };
}

class YouTubeVideoPlayer extends StatefulWidget {
  final String videoId;

  YouTubeVideoPlayer({required this.videoId});

  @override
  _YouTubeVideoPlayerState createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(

      videoId: YoutubePlayerController.convertUrlToId(widget.videoId)!,
      autoPlay: true,
      startSeconds: 0,
      params: const YoutubePlayerParams(
        playsInline: false,
        loop: false, // Убираем встроенную петлю, чтобы вручную контролировать воспроизведение
        showControls: false,
        showFullscreenButton: false,
        showVideoAnnotations: false,
        enableCaption: false,
        enableJavaScript: true,
        strictRelatedVideos: true,
      ),
    );

    _controller.listen((event) {
      if (event.playerState == PlayerState.ended) {
        _controller.seekTo(seconds: 0);
        _controller.playVideo();
      }
    });

  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}

// class YouTubeVideoPlayer extends StatefulWidget {
//   final String videoId;
//
//   YouTubeVideoPlayer({required this.videoId});
//
//   @override
//   _YouTubeVideoPlayerState createState() => _YouTubeVideoPlayerState();
// }
//
// class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
//    late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController.fromVideoId(
//       videoId:YoutubePlayerController.convertUrlToId(widget.videoId)!,
//       autoPlay: true,
//       startSeconds:15,
//       params: const YoutubePlayerParams(
//
//         playsInline: false,
//         loop: true,
//         showControls: false,
//         showFullscreenButton: false,
//         showVideoAnnotations: false,
//         enableCaption: false,
//         enableJavaScript: false, // Enable JavaScript for better compatibility
//       ),
//     );
//
//   }
//
//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       height: 150,
//       child: YoutubePlayer(
//         controller: _controller,
//         aspectRatio: 16 /9,
//       ),
//     );
//   }
// }

