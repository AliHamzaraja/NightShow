import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nightshow/Models/upcomingmovie_model.dart';
import 'package:video_player/video_player.dart';

import '../common/common_widget.dart';
import '../utils/appColors.dart';
import '../utils/appConstants.dart';

class PlayVideoScreen extends StatefulWidget {
  final Results movie;

  PlayVideoScreen({required this.movie});

  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  Future<void> initializePlayer() async {
    ///as we have no url in api so demi url is added for demo
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: MyTextView(
            errorMessage,
            textStyleNew: MyTextStyle(
                textColor: AppColors.white,
                textSize: 14.sp,
                textWeight: AppConstant.bold),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
    // Replace with your actual trailer URL

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        // Video playback is finished
        Navigator.of(context).pop(); // Close the fullscreen player
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.cyanColor,
        title: MyTextView(
          widget.movie.title!,
          maxLinesNew: 1,
          textStyleNew: MyTextStyle(
              textColor: AppColors.white,
              textSize: 20.sp,
              textWeight: AppConstant.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !_videoPlayerController.value.isInitialized
                ? CircularProgressIndicator()
                : Expanded(
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.cyanColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: MyTextView(
            'Done',
            textStyleNew: MyTextStyle(
                textColor: AppColors.white,
                textSize: 14.sp,
                textWeight: AppConstant.bold),
          ),
        ),
      ),
    );
  }
}
