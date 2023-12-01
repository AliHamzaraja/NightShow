import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/common_widget.dart';
import '../utils/appColors.dart';
import '../utils/appConstants.dart';

class SeatMappingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cyanColor,
        centerTitle: true,
        title: MyTextView(
          'Seat Map',
          maxLinesNew: 1,
          textStyleNew: MyTextStyle(
              textColor: AppColors.white,
              textSize: 16.sp,
              textWeight: AppConstant.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // Adjust the number of columns as needed
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 30, // Total number of seats
                itemBuilder: (context, index) {
                  // Logic to determine seat status (e.g., available, booked)
                  bool isAvailable = index % 2 == 0;

                  return SeatWidget(
                    seatNumber: index + 1,
                    isAvailable: isAvailable,
                    onPressed: () {
                      print('Seat ${index + 1} tapped');
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.0.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.cyanColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: MyTextView(
              'Book Tickets',
              textStyleNew: MyTextStyle(
                  textColor: AppColors.white,
                  textSize: 14.sp,
                  textWeight: AppConstant.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final bool isAvailable;
  final VoidCallback onPressed;

  SeatWidget({
    required this.seatNumber,
    required this.isAvailable,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor = isAvailable ? Colors.green : Colors.red;
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: MyTextView(
          '$seatNumber',
          maxLinesNew: 1,
          textStyleNew: MyTextStyle(
              textColor: AppColors.white,
              textSize: 16.sp,
              textWeight: AppConstant.bold),
        ),
      ),
    );
  }
}
