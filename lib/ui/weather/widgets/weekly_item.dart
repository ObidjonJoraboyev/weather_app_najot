import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class WeeklyItem extends StatelessWidget {
  const WeeklyItem(
      {super.key,
      required this.when,
      required this.weather,
      required this.imageUrl});

  final String when;
  final String imageUrl;
  final int weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white.withValues(alpha: .36),
        border: Border.fromBorderSide(
          BorderSide(
            width: 0.5.w,
            color: Colors.white.withValues(alpha: .4),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            when,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text(
            "$weather°",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          5.getW(),
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: 32.w,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
