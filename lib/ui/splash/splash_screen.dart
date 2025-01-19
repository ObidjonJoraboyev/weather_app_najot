import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app_nt/ui/weather/widgets/background.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/constants/route_names.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
      Navigator.pushReplacementNamed(context, RouteNames.daily);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          AppBackground(),
          Positioned(
            bottom: 21.h,
            child: Row(
              children: [
                Text(
                  "Designed by Obidjon",
                  style: TextStyle(
                    color: AppColors.textColors,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SvgPicture.asset(
              "assets/icons/weather.svg",
              width: width,
            ),
          )
        ],
      ),
    );
  }
}
