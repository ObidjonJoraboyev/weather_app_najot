import 'package:weather_app_nt/data/models/form_status.dart';
import 'package:weather_app_nt/data/models/weather_model.dart';

class WeatherState {
  final WeatherModel weatherModel;
  final String errorMessage;
  final String actionMessage;
  final FormStatus status;
  final List<WeatherModel> weeklyWeathers;

  WeatherState({
    required this.weatherModel,
    required this.weeklyWeathers,
    this.errorMessage = '',
    this.actionMessage = '',
    this.status = FormStatus.pure,
  });

  WeatherState copyWith({
    WeatherModel? weatherModel,
    String? errorMessage,
    String? actionMessage,
    FormStatus? status,
    List<WeatherModel>? weeklyWeathers,
  }) {
    return WeatherState(
      weatherModel: weatherModel ?? this.weatherModel,
      errorMessage: errorMessage ?? this.errorMessage,
      actionMessage: actionMessage ?? this.actionMessage,
      status: status ?? this.status,
      weeklyWeathers: weeklyWeathers ?? this.weeklyWeathers,
    );
  }
}
