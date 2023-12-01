// screens/movie_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nightshow/Provider/movieImageProvider.dart';
import 'package:nightshow/View/seatmapScreen.dart';
import 'package:nightshow/utils/appUrls.dart';
import 'package:provider/provider.dart';

import '../Models/upcomingmovie_model.dart';
import '../Provider/movieProvider.dart';
import '../common/common_widget.dart';
import '../utils/appColors.dart';
import '../utils/appConstants.dart';
import 'movieDetailpage.dart';

class UpcomingMovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MovieProvider>(context);

    return FutureBuilder<UpComingMovies>(
      future: movieProvider.movies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return MyTextView(
            'Error: ${snapshot.error}',
            textStyleNew: MyTextStyle(
                textColor: AppColors.black,
                textSize: 14.sp,
                textWeight: AppConstant.bold),
          );
        } else if (snapshot.hasData) {
          UpComingMovies upComingMovies = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.50,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: upComingMovies.results!.length,
            itemBuilder: (context, index) {
              var movie = upComingMovies.results![index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetail(movie: movie),
                        ),
                      );
                      Provider.of<MovieImageProvider>(context, listen: false)
                          .moviesImages(movie.id!);
                    },
                    child: Image.network(
                      AppStringsUtil.imagebaseurl + movie.posterPath!,
                      height: 330,
                      width: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      children: [
                        // Dots icon and PopupMenuButton

                        // Movie title
                        Expanded(
                          child: MyTextView(
                            movie.title!,
                            maxLinesNew: 2,
                            textStyleNew: MyTextStyle(
                              textColor: AppColors.white,
                              textSize: 14.sp,
                              textWeight: AppConstant.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            _showPopupMenu(context, movie);
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return MyTextView(
            'Error: ${snapshot.error}',
            textStyleNew: MyTextStyle(
                textColor: AppColors.black,
                textSize: 14.sp,
                textWeight: AppConstant.bold),
          );
        }
      },
    );
  }
}

void _showPopupMenu(BuildContext context, Results movie) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.book),
              title: MyTextView(
                'Book Tickets Now',
                maxLinesNew: 1,
                textStyleNew: MyTextStyle(
                    textColor: AppColors.black,
                    textSize: 16.sp,
                    textWeight: AppConstant.bold),
              ),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                // Navigate to the seat mapping screen or perform any other action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeatMappingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
