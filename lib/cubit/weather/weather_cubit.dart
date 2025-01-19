import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_nt/cubit/location/location_cubit.dart';
import 'package:weather_app_nt/cubit/weather/weather_state.dart';
import 'package:weather_app_nt/data/models/form_status.dart';
import 'package:weather_app_nt/data/models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(super.initialState);

  Dio dio = Dio();

  getTodayWeather(BuildContext context, [String query = ""]) async {
    num lat = context.read<LocationCubit>().state.lat;
    num long = context.read<LocationCubit>().state.long;

    emit(state.copyWith(status: FormStatus.loading));
    try {
      Response response = await dio.get(
          "https://api.weatherapi.com/v1/forecast.json?q=${query.isNotEmpty ? query : "$lat%2C$long"}&days=1&key=67c354f1a9f946a3a88163852230512");
      if (response.statusCode == 200) {
        WeatherModel weatherModel =
            WeatherModel.fromJson(response.data as Map<String, dynamic>? ?? {});
        emit(state.copyWith(
            status: FormStatus.success, weatherModel: weatherModel));
      }
    } on DioException catch (err) {
      emit(state.copyWith(status: FormStatus.error));
      debugPrint(err.error.toString());
    } catch (v) {
      emit(state.copyWith(status: FormStatus.error));
      debugPrint(v.toString());
    }
  }

  getWeeklyWeather(BuildContext context, [String query = ""]) async {
    num lat = context.read<LocationCubit>().state.lat;
    num long = context.read<LocationCubit>().state.long;

    emit(state.copyWith(status: FormStatus.loading));
    try {
      Response response = await dio.get(
          "https://api.weatherapi.com/v1/forecast.json?q=${query.isNotEmpty ? query : "$lat%2C$long"}&days=7&key=67c354f1a9f946a3a88163852230512");
      if (response.statusCode == 200) {
        List<WeatherModel> weatherModel =
            (response.data["forecast"]["forecastday"] as List)
                .map((v) =>
                    WeatherModel.fromJsonWithoutHour(v as Map<String, dynamic>))
                .toList();
        emit(state.copyWith(
            status: FormStatus.success, weeklyWeathers: weatherModel));
      }
    } on DioException catch (err) {
      emit(state.copyWith(status: FormStatus.error));
      debugPrint(err.error.toString());
    } catch (v) {
      emit(state.copyWith(status: FormStatus.error));
      debugPrint(v.toString());
    }
  }
}
