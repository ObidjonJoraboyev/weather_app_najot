import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nt/cubit/location/location_cubit.dart';
import 'package:weather_app_nt/cubit/weather/weather_cubit.dart';
import 'package:weather_app_nt/cubit/weather/weather_state.dart';
import 'package:weather_app_nt/data/models/form_status.dart';
import 'package:weather_app_nt/ui/weather/widgets/background.dart';
import 'package:weather_app_nt/ui/weather/widgets/base_weather_container.dart';
import 'package:weather_app_nt/ui/weather/widgets/hourly_widget.dart';
import 'package:weather_app_nt/ui/widgets/become_blur.dart';
import 'package:weather_app_nt/utils/colors.dart';
import 'package:weather_app_nt/utils/constants/route_names.dart';
import 'package:weather_app_nt/utils/icons/app_icons.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  @override
  void initState() {
    context.read<LocationCubit>().state.lat == 0
        ? context.read<LocationCubit>().getLocation(context)
        : 1;
    super.initState();
  }

  String searchedString = "";
  bool isOpenSearch = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              AppBackground(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isOpenSearch = !isOpenSearch;
                            setState(() {});
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: isOpenSearch
                                ? Icon(Icons.close)
                                : SvgPicture.asset(
                                    AppIcons.search,
                                    width: 24.sp,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            transitionBuilder: (child, animation) {
                              return SizeTransition(
                                axisAlignment: 1,
                                sizeFactor: animation,
                                child: child,
                              );
                            },
                            child: isOpenSearch
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: TextField(
                                      onSubmitted: (v) {
                                        searchedString = v;
                                        v.isEmpty ? isOpenSearch = false : 1;
                                        setState(() {});
                                        context
                                            .read<WeatherCubit>()
                                            .getTodayWeather(context, v);
                                      },
                                      cursorColor: AppColors.secondGradient,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: "Search somewhere",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          borderSide: BorderSide(
                                            color: AppColors.secondGradient,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          borderSide: BorderSide(
                                            color: AppColors.secondGradient,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ),
                        SvgPicture.asset(
                          AppIcons.right,
                          width: 24.sp,
                        ),
                      ],
                    ),
                  ),
                  21.getH(),
                  Expanded(
                    child: RefreshIndicator(
                      backgroundColor: AppColors.firstGradient,
                      color: AppColors.secondGradient,
                      onRefresh: () async {
                        context.read<WeatherCubit>().getTodayWeather(context);
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.weatherModel.regionName},\n${state.weatherModel.country}",
                                  style: TextStyle(
                                      color: AppColors.textColors,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24.sp,
                                      fontFamily: "Inter"),
                                  textAlign: TextAlign.start,
                                ),
                                6.getH(),
                                Text(
                                  state.weatherModel.date,
                                  style: TextStyle(
                                      color: AppColors.dimTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp),
                                ),
                                9.getH(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    state.weatherModel.imageUrl.isNotEmpty
                                        ? Image.network(
                                            state.weatherModel.imageUrl,
                                            height: 100.h,
                                            fit: BoxFit.cover,
                                          )
                                        : SizedBox(),
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weatherModel.currentWeather
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 50.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textColors,
                                              ),
                                            ),
                                            Text(
                                              "° C",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                16.getH(),
                                BaseWeatherContainer(
                                  icon: AppIcons.umbrella,
                                  title: "RainFall",
                                  data: "${state.weatherModel.rainFall}sm",
                                ),
                                8.getH(),
                                BaseWeatherContainer(
                                  icon: AppIcons.wind,
                                  title: "Wind",
                                  data: "${state.weatherModel.windSpeed}km/h",
                                ),
                                8.getH(),
                                BaseWeatherContainer(
                                  icon: AppIcons.humidity,
                                  title: "Humidity",
                                  data: "${state.weatherModel.humidity}%",
                                ),
                                15.getH(),
                                Row(
                                  children: [
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                        color: AppColors.textColors,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    12.getW(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteNames.weekly,
                                            arguments: searchedString);
                                      },
                                      child: Text(
                                        "Tomorrow",
                                        style: TextStyle(
                                          color: AppColors.cD6996B,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteNames.weekly,
                                            arguments: searchedString);
                                      },
                                      child: Text(
                                        "Next 7 days",
                                        style: TextStyle(
                                          color: AppColors.cD6996B,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    6.getW(),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      color: AppColors.cD6996B,
                                    )
                                  ],
                                ),
                                12.getH(),
                                SliderTheme(
                                  data: SliderThemeData(
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 10.sp,
                                      elevation: 120,
                                      pressedElevation: 120,
                                    ),
                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 10,
                                    ),
                                    trackHeight: 1,
                                  ),
                                  child: Slider(
                                    allowedInteraction:
                                        SliderInteraction.tapOnly,
                                    value: getValue(),
                                    max: 100,
                                    min: 0,
                                    onChanged: (v) {},
                                    activeColor: Color(0xffE2A272),
                                    inactiveColor: Color(0xffE2A272),
                                    thumbColor: Colors.yellow,
                                  ),
                                ),
                                8.getH(),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                13.getW(),
                                ...List.generate(
                                    state.weatherModel.hourlyWeather.length,
                                    (index) {
                                  return HourlyWidget(
                                      isActive: state.weatherModel
                                          .hourlyWeather[index].when
                                          .contains(
                                              DateTime.now().hour.toString()),
                                      when: state.weatherModel
                                          .hourlyWeather[index].when,
                                      imageUrl: state.weatherModel
                                          .hourlyWeather[index].imageUrl,
                                      radius: state.weatherModel
                                          .hourlyWeather[index].weather
                                          .toString());
                                }),
                                13.getW(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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

double getValue() {
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;
  int seconds = DateTime.now().second;
  return ((hour * 3600 + minute * 60 + seconds) / 86400) * 100;
}
