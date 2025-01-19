import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nt/ui/weather/widgets/images_widget.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class BaseWeatherContainer extends StatelessWidget {
  const BaseWeatherContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  final String icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: CupertinoColors.white.withValues(alpha: .36),
        border: Border.fromBorderSide(
          BorderSide(
            width: 0.5.w,
            color: CupertinoColors.white.withValues(alpha: .5),
          ),
        ),
      ),
      child: Row(
        children: [
          ImagesWidget(icon: icon),
          8.getW(),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textColors,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
          Spacer(),
          Text(
            data,
            style: TextStyle(
              color: AppColors.textColors,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          10.getW()
        ],
      ),
    );
  }
}
