import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ImagesWidget extends StatelessWidget {
  const ImagesWidget({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 10,
            color: Colors.black.withValues(alpha: .07),
          )
        ],
        color: Colors.white.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: SvgPicture.asset(
        icon,
        width: 25.w,
        height: 25.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
