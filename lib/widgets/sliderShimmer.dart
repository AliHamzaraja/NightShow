import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nightshow/utils/appColors.dart';

class ShimmerEffectWidget extends StatelessWidget {
  const ShimmerEffectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220.h,
          width: 384.w,
          color: AppColors.grey,
        ),
      ],
    );
  }
}
