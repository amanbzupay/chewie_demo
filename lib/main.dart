import 'package:demo2/theme.dart';
import 'package:demo2/video_player_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: VideoPlayerScreen(
        items: [
          PromoModel(
            intentType: '',
            intent:
                'https://zpmediateststorageacc.blob.core.windows.net/zuacademytestmedia/others/tutorial_videos/1_Market%20Capitalisation.mp4',
            altText: '',
            apiOnCall: '',
            dimensions: '',
            imageUrl: '',
            isFeature: false,
            thumbNail: '',
          )
        ],
      ),
    );
  }
}
