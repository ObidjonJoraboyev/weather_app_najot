import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class HourlyWidget extends StatelessWidget {
  const HourlyWidget(
      {super.key,
      required this.isActive,
      required this.when,
      required this.imageUrl,
      required this.radius});

  final bool isActive;
  final String when;
  final String imageUrl;
  final String radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: isActive
            ? CupertinoColors.white.withValues(alpha: .7)
            : CupertinoColors.white.withValues(alpha: .3),
      ),
      child: Column(
        children: [
          Text(
            when,
            style: TextStyle(
              color: isActive ? AppColors.textColors : AppColors.dimTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
          2.getH(),
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: 32.w,
                  fit: BoxFit.cover,
                )
              : SizedBox(),
          2.getH(),
          Text(
            "$radius°",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: AppColors.textColors,
            ),
          )
        ],
      ),
    );
  }
}
