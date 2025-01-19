import 'package:weather_app_nt/ui/weather/hourly_model.dart';
import 'package:weather_app_nt/utils/utils.dart';

class WeatherModel {
  final String regionName;
  final String country;
  final String date;
  final int currentWeather;
  final String imageUrl;
  final int windSpeed;
  final int humidity;
  final int rainFall;
  final List<HourlyModel> hourlyWeather;

  WeatherModel({
    required this.regionName,
    required this.country,
    required this.date,
    required this.currentWeather,
    required this.imageUrl,
    required this.windSpeed,
    required this.humidity,
    required this.rainFall,
    required this.hourlyWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        regionName: json["location"]['region'] as String? ?? "",
        country: json['location']["country"] as String? ?? "",
        date: UtilityFunctions().getDateTimeString(
          json["location"]["localtime_epoch"] as int? ?? 0,
        ),
        currentWeather: (json["current"]["temp_c"] as num? ?? 0).toInt(),
        imageUrl:
            "http:${json["current"]["condition"]["icon"] as String? ?? ""}",
        windSpeed: (json["current"]["wind_kph"] as num? ?? 0).toInt(),
        humidity: (json["current"]["humidity"] as num? ?? 0).toInt(),
        rainFall: ((json["current"]["precip_mm"] as num? ?? 0) / 10).toInt(),
        hourlyWeather: (json["forecast"]["forecastday"][0]["hour"] as List? ??
                [])
            .map(
                (model) => HourlyModel.fromJson(model as Map<dynamic, dynamic>))
            .toList());
  }

  factory WeatherModel.fromJsonWithoutHour(Map<String, dynamic> json) {
    return WeatherModel(
      regionName: "",
      country: "",
      date: UtilityFunctions().getWeekName(json["date"] as String? ?? ""),
      currentWeather: (json["day"]["avgtemp_c"] as num? ?? 0).toInt(),
      imageUrl: "http:${json["day"]["condition"]["icon"] as String? ?? ""}",
      windSpeed: (json["day"]["maxwind_kph"] as num? ?? 0).toInt(),
      humidity: (json["day"]["avghumidity"] as num? ?? 0).toInt(),
      rainFall: ((json["day"]["totalprecip_mm"] as num? ?? 0) / 10).toInt(),
      hourlyWeather: [],
    );
  }

  static WeatherModel initialValue() {
    return WeatherModel(
      regionName: "",
      country: "",
      date: "",
      currentWeather: 0,
      imageUrl: "",
      windSpeed: 0,
      humidity: 0,
      rainFall: 0,
      hourlyWeather: [],
    );
  }
}
