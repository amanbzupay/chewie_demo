import 'package:chewie/chewie.dart';
import 'package:demo2/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPlayerScreen extends StatelessWidget {
  final List<PromoModel> items;
  Map<String, dynamic>? properties;
  VideoPlayerScreen({Key? key, required this.items, this.properties})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            height: double.infinity,
            width: SizeConfig.deviceWidth! * 100,
            child: Center(
              child: VerticalVideoPlayer(items: items, properties: properties),
            ),
          ),
          SafeArea(
            child: Positioned(
              top: SizeConfig.deviceHeight! * .1,
              child: Padding(
                padding: EdgeInsets.only(top: ZuAppDimensions.paddingMinimum),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: SizeConfig.deviceHeight! * 3,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VerticalVideoPlayer extends StatefulWidget {
  final List<PromoModel> items;
  Map<String, dynamic>? properties;
  VerticalVideoPlayer({required this.items, this.properties});

  @override
  _VerticalVideoPlayerState createState() => _VerticalVideoPlayerState();
}

class _VerticalVideoPlayerState extends State<VerticalVideoPlayer> {
  late final VideoPlayerController _videoPlayerController;
  late final ChewieController _chewieController;
  bool isLoaded = false;

  double videoContainerRatio = 0.5;

  double getScale() {
    final double videoRatio = _videoPlayerController.value.aspectRatio;

    if (videoRatio < videoContainerRatio) {
      return videoContainerRatio / videoRatio;
    } else {
      return videoRatio / videoContainerRatio;
    }
  }

  @override
  void initState() {
    super.initState();

    _initPlayer();
  }

  void checkVideoDuration() {
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      // final Map<String, dynamic> secondProperties = SegmentKeys.segmentMap(
      //     fromSource: ' ${SegmentKeys.videoCompleted}',
      //     fromScreen: zuRouter.current.name);
      // widget.properties
      //     ?.addAll({SegmentKeys.videoURL: widget.items.first.intent});
      // secondProperties.addAll(widget.properties as Map<String, dynamic>);
      // SegmentService.track(
      //     eventName: SegmentKeys.videoCompleted, properties: secondProperties);
    }
  }

  Future _initPlayer() async {
    _videoPlayerController = VideoPlayerController.network(
        replaceAllWhiteSpaces(widget.items.first.intent));
    await _videoPlayerController.initialize();
    // _videoPlayerController.addListener(checkVideoDuration);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      // aspectRatio: _videoPlayerController.value.aspectRatio,
      looping: false,
      allowFullScreen: false,
      showControls: false,
      showControlsOnInitialize: false,
    );
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Transform.scale(
            scale: getScale(),
            child: AspectRatio(
              aspectRatio: videoContainerRatio,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          )
        : const Center(
            child: FlutterLogo(),
          );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

String replaceAllWhiteSpaces(String videoUrl) {
  return videoUrl.replaceAll(" ", "%20");
}
