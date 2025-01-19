import 'package:flutter/material.dart';
import 'package:weather_app_nt/app/app.dart';
import 'package:weather_app_nt/ui/splash/splash_screen.dart';
import 'package:weather_app_nt/ui/weather/current_weather.dart';
import 'package:weather_app_nt/ui/weather/weekly_weather.dart';
import 'package:weather_app_nt/utils/constants/route_names.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    currentPath = settings.name.toString();
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RouteNames.weekly:
        return MaterialPageRoute(
          builder: (_) => WeeklyWeatherScreen(
            searchedString: settings.arguments! as String,
          ),
        );
      case RouteNames.daily:
        return MaterialPageRoute(
          builder: (_) => const CurrentWeatherScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No Route"),
            ),
          ),
        );
    }
  }
}
