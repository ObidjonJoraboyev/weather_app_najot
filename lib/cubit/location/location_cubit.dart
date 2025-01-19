import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_nt/cubit/location/location_state.dart';
import 'package:weather_app_nt/cubit/weather/weather_cubit.dart';
import 'package:weather_app_nt/utils/utils.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(super.initialState);

  getLocation(BuildContext context) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(status: LocationStatus.denied));
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever ||
            permission == LocationPermission.unableToDetermine) {
          if (!context.mounted) return;
          Dialogs().showWarningDialog(context);
          emit(state.copyWith(status: LocationStatus.denied));
          return;
        }
      }

      emit(state.copyWith(status: LocationStatus.granted));
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      emit(state.copyWith(lat: position.latitude, long: position.longitude));
      if (!context.mounted) return;
      context.read<WeatherCubit>().getTodayWeather(context);
    } catch (e) {
      if (!context.mounted) return;
      Dialogs().showWarningDialog(context);

      debugPrint(e.toString());
      emit(state.copyWith(
          errorMessage: e.toString(), status: LocationStatus.error));
    }
  }
}
