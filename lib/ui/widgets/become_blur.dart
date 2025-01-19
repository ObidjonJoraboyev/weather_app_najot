import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app_nt/utils/colors.dart';

class BecomeBlur extends StatelessWidget {
  const BecomeBlur(this.isLoading, {super.key});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondGradient,
                    strokeCap: StrokeCap.butt,
                    strokeAlign: 2,
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
