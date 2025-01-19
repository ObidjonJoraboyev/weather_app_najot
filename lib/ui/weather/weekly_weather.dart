import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nt/cubit/weather/weather_cubit.dart';
import 'package:weather_app_nt/cubit/weather/weather_state.dart';
import 'package:weather_app_nt/data/models/form_status.dart';
import 'package:weather_app_nt/data/models/weather_model.dart';
import 'package:weather_app_nt/ui/weather/widgets/background.dart';
import 'package:weather_app_nt/ui/weather/widgets/tomorrow_widget.dart';
import 'package:weather_app_nt/ui/weather/widgets/weekly_item.dart';
import 'package:weather_app_nt/ui/widgets/become_blur.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class WeeklyWeatherScreen extends StatefulWidget {
  const WeeklyWeatherScreen({super.key, required this.searchedString});

  final String searchedString;

  @override
  State<WeeklyWeatherScreen> createState() => _WeeklyWeatherScreenState();
}

class _WeeklyWeatherScreenState extends State<WeeklyWeatherScreen> {
  @override
  void initState() {
    context
        .read<WeatherCubit>()
        .getWeeklyWeather(context, widget.searchedString);
    super.initState();
  }

  WeatherModel tomorrowWeather = WeatherModel.initialValue();
  List<WeatherModel> weekly = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status == FormStatus.success) {
          weekly = state.weeklyWeathers.sublist(2);
          tomorrowWeather = state.weeklyWeathers[1];
        }
        return Scaffold(
          body: Stack(
            children: [
              AppBackground(),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            weight: 24.sp,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: Text(
                                  "Next 7 Days in ${state.weatherModel.regionName}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.getH(),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: RefreshIndicator(
                      backgroundColor: AppColors.firstGradient,
                      color: AppColors.secondGradient,
                      onRefresh: () async {
                        context
                            .read<WeatherCubit>()
                            .getWeeklyWeather(context, widget.searchedString);
                      },
                      child: ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.zero,
                        children: [
                          TomorrowWidget(
                            weather: tomorrowWeather.currentWeather,
                            rainfall: tomorrowWeather.rainFall,
                            wind: tomorrowWeather.windSpeed,
                            humidity: tomorrowWeather.humidity,
                            imageUrl: tomorrowWeather.imageUrl,
                          ),
                          16.getH(),
                          ...List.generate(weekly.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5.h),
                              child: WeeklyItem(
                                when: weekly[index].date,
                                weather: weekly[index].currentWeather,
                                imageUrl: weekly[index].imageUrl,
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              BecomeBlur(state.status == FormStatus.loading)
            ],
          ),
        );
      },
    );
  }
}
