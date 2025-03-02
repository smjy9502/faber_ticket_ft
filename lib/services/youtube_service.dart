import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/material.dart';

class YoutubeService {
  void playVideo(String url, BuildContext context) {
    final videoId = YoutubePlayerController.convertUrlToId(url);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('YouTube Video')),
          body: YoutubePlayerIFrame(
            controller: YoutubePlayerController(
              initialVideoId: videoId!,
              params: YoutubePlayerParams(
                autoPlay: true,
                showControls: true,
                showFullscreenButton: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
