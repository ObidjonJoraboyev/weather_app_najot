import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app_nt/utils/colors.dart';

class UtilityFunctions {
  Future<void> openAppSettings() async {
    final Uri appSettingsUri = Uri(scheme: 'app-settings');

    if (await canLaunchUrl(appSettingsUri)) {
      await launchUrl(appSettingsUri);
    } else {
      debugPrint('Unable to open app settings.');
    }
  }

  String getDateTimeString(int epoch) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('EEE, MMM d').format(date);
  }

  String getHourMinutes(String time) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm').format(dateTime);
  }

  String getWeekName(String time) {
    DateTime date = DateTime.parse(time);
    return DateFormat('EEEE').format(date);
  }
}

class Dialogs {
  showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (c) {
          return Platform.isAndroid
              ? AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text("Warning"),
                  content: Text(
                      "In order to show you the weather, we need to know where you are."),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await UtilityFunctions().openAppSettings();
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      child: Text("Settings"),
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: Text("Warning"),
                  content: Text(
                      "In order to show you the weather, we need to know where you are."),
                  actions: [
                    CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(color: AppColors.secondGradient))),
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        await UtilityFunctions().openAppSettings();
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Settings",
                        style: TextStyle(color: AppColors.secondGradient),
                      ),
                    ),
                  ],
                );
        });
  }
}
