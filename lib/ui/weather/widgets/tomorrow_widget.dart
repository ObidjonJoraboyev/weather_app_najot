import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nt/ui/weather/widgets/images_widget.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/icons/app_icons.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class TomorrowWidget extends StatelessWidget {
  const TomorrowWidget({
    super.key,
    required this.weather,
    required this.rainfall,
    required this.wind,
    required this.humidity,
    required this.imageUrl,
  });

  final int weather;
  final int rainfall;
  final int wind;
  final int humidity;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 11.w, right: 11.w, bottom: 19.h, top: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white.withValues(alpha: 0.8),
            width: 0.5.w,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Tomorrow",
                style: TextStyle(
                    color: AppColors.textColors,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp),
              ),
              Spacer(),
              Text(
                "$weather°",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
              ),
              5.getW(),
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      height: 32.h,
                    )
                  : SizedBox()
            ],
          ),
          11.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ImagesWidget(icon: AppIcons.umbrella),
                  8.getH(),
                  Text(
                    "${rainfall}sm",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              21.getW(),
              Column(
                children: [
                  ImagesWidget(icon: AppIcons.wind),
                  8.getH(),
                  Text(
                    "${wind}km/h",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              21.getW(),
              Column(
                children: [
                  ImagesWidget(icon: AppIcons.humidity),
                  8.getH(),
                  Text(
                    "$humidity%",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
