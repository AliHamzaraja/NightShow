import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nightshow/utils/appColors.dart';
import 'package:nightshow/utils/appConstants.dart';

import '../common/common_widget.dart';
import 'UpComingMovies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.cyanColor,
        centerTitle: true,
        title: MyTextView(
          "Upcoming Movies",
          textStyleNew: MyTextStyle(
              textColor: AppColors.white,
              textSize: 20.sp,
              textWeight: AppConstant.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UpcomingMovieList(),
      ),
    );
  }
}
