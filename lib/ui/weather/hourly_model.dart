import 'package:weather_app_nt/utils/utils.dart';

class HourlyModel {
  final String when;
  final String imageUrl;
  final int weather;

  HourlyModel({
    required this.when,
    required this.imageUrl,
    required this.weather,
  });

  factory HourlyModel.fromJson(Map<dynamic, dynamic> json) {
    return HourlyModel(
      when: UtilityFunctions().getHourMinutes(json['time'] as String? ?? ""),
      imageUrl: "http:${json['condition']["icon"] as String? ?? ""}",
      weather: (json['temp_c'] as num? ?? 0).toInt(),
    );
  }
}
