import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:nightshow/View/homepage.dart';
import 'package:nightshow/utils/appColors.dart';

import '../common/common_widget.dart';
import '../utils/appConstants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  splashfunc() async {
    Timer(const Duration(seconds: 5), () {
      Get.offAll(const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    splashfunc();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: DefaultTextStyle(
          style: MyTextStyle(
              textColor: AppColors.white,
              textSize: 30.sp,
              textWeight: AppConstant.bold),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              RotateAnimatedText(
                'Night',
              ),
              RotateAnimatedText('Show'),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ),
    );
  }
}
