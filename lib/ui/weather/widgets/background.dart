import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/icons/app_icons.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.firstGradient,
                AppColors.secondGradient,
              ],
            ),
          ),
        ),
        Stack(
          children: [
            SvgPicture.asset(
              AppIcons.background,
              width: MediaQuery.of(context).size.width + 100,
              height: MediaQuery.of(context).size.height + 100,
              fit: BoxFit.cover,
            ),

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 500.0, sigmaY: 500.0),
              child: Container(
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),

            // Foreground content
          ],
        ),
      ],
    );
  }
}
