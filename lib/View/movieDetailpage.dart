import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:nightshow/Models/upcomingmovie_model.dart';
import 'package:nightshow/View/playVideoScreen.dart';
import 'package:nightshow/utils/appUrls.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Provider/movieImageProvider.dart';
import '../common/common_widget.dart';
import '../utils/appColors.dart';
import '../utils/appConstants.dart';
import '../widgets/sliderShimmer.dart';

class MovieDetail extends StatelessWidget {
  final Results movie;
  MovieDetail({super.key, required this.movie});
  final CarouselController controller = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.cyanColor,
        centerTitle: true,
        title: MyTextView(
          movie.title!,
          maxLinesNew: 1,
          textStyleNew: MyTextStyle(
              textColor: AppColors.white,
              textSize: 20.sp,
              textWeight: AppConstant.bold),
        ),
      ),
      body: Consumer<MovieImageProvider>(builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              provider.isLoading
                  ? Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        enabled: true,
                        direction: ShimmerDirection.ltr,
                        period: const Duration(seconds: 1),
                        child: const ShimmerEffectWidget(),
                      ),
                    )
                  : provider.movieImagesModel.backdrops!.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 220.h,
                              width: 384.w,
                              child: CarouselSlider(
                                carouselController: controller,
                                options: CarouselOptions(
                                  // height: height,
                                  autoPlay: true,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,

                                  onPageChanged: (index, reason) {
                                    provider.setCurrentIndex(index);
                                  },
                                ),
                                items: provider.movieImagesModel.backdrops!
                                    .map((item) {
                                  return PhotoView(
                                    disableGestures: true,
                                    initialScale:
                                        PhotoViewComputedScale.covered,
                                    imageProvider: NetworkImage(
                                      '${AppStringsUtil.imagebaseurl}${item.filePath}',
                                    ),
                                    loadingBuilder: (context, event) => Center(
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        child: CircularProgressIndicator(
                                          //color: CustomColors.primaryblueColor,
                                          value: event == null
                                              ? 0
                                              : event.cumulativeBytesLoaded /
                                                  event.expectedTotalBytes!,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, top: 10.h),
                              child: SizedBox(
                                height: 20.0.h, // Adjust the height as needed
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(
                                    initialScrollOffset:
                                        provider.currentIndex.toDouble() *
                                            30.0, // Adjust the scroll offset
                                  ),
                                  itemCount: provider
                                      .movieImagesModel.backdrops!.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    child: Container(
                                      width: 8.0.w,
                                      height: 8.0.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: provider.currentIndex == index
                                            ? AppColors.cyanColor
                                            : AppColors
                                                .grey, // Customize dot colors as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: MyTextView(
                            'No Data',
                            textStyleNew: MyTextStyle(
                                textColor: AppColors.black,
                                textSize: 14.sp,
                                textWeight: AppConstant.bold),
                          ),
                        ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: RichText(
                  text: TextSpan(
                    text: 'Title: ',
                    style: MyTextStyle(
                        textColor: AppColors.white,
                        textSize: 16.sp,
                        textWeight: AppConstant.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: movie.title!,
                        style: MyTextStyle(
                            textColor: AppColors.white,
                            textSize: 16.sp,
                            textWeight: AppConstant.regular),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: RichText(
                  text: TextSpan(
                    text: 'Popularity: ',
                    style: MyTextStyle(
                        textColor: AppColors.white,
                        textSize: 16.sp,
                        textWeight: AppConstant.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${movie.popularity!}',
                        style: MyTextStyle(
                            textColor: AppColors.white,
                            textSize: 16.sp,
                            textWeight: AppConstant.regular),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: RichText(
                  text: TextSpan(
                    text: 'Original Language: ',
                    style: MyTextStyle(
                        textColor: AppColors.white,
                        textSize: 16.sp,
                        textWeight: AppConstant.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: movie.originalLanguage!.toUpperCase(),
                        style: MyTextStyle(
                            textColor: AppColors.white,
                            textSize: 16.sp,
                            textWeight: AppConstant.regular),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: RichText(
                  text: TextSpan(
                    text: 'Overview: ',
                    style: MyTextStyle(
                        textColor: AppColors.white,
                        textSize: 16.sp,
                        textWeight: AppConstant.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: movie.overview!,
                        style: MyTextStyle(
                            textColor: AppColors.white,
                            textSize: 16.sp,
                            textWeight: AppConstant.regular),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => PlayVideoScreen(movie: movie));
                },
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.cyanColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.white,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      MyTextView(
                        'Watch Trailer',
                        textStyleNew: MyTextStyle(
                            textColor: AppColors.white,
                            textSize: 14.sp,
                            textWeight: AppConstant.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.add_circle_outline_outlined,
                      color: AppColors.white,
                      size: 25.r,
                    ),
                    MyTextView(
                      'My List',
                      textStyleNew: MyTextStyle(
                          textColor: AppColors.white,
                          textSize: 14.sp,
                          textWeight: AppConstant.bold),
                    ),
                    Icon(
                      Icons.share,
                      color: AppColors.white,
                      size: 25.r,
                    ),
                    MyTextView(
                      'Share',
                      textStyleNew: MyTextStyle(
                          textColor: AppColors.white,
                          textSize: 14.sp,
                          textWeight: AppConstant.bold),
                    ),
                    Icon(
                      Icons.thumb_up,
                      color: AppColors.white,
                      size: 25.r,
                    ),
                    MyTextView(
                      'Like',
                      textStyleNew: MyTextStyle(
                          textColor: AppColors.white,
                          textSize: 14.sp,
                          textWeight: AppConstant.bold),
                    ),
                    Icon(
                      Icons.thumb_down,
                      color: AppColors.white,
                      size: 25.r,
                    ),
                    MyTextView(
                      'Dislike',
                      textStyleNew: MyTextStyle(
                          textColor: AppColors.white,
                          textSize: 14.sp,
                          textWeight: AppConstant.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
