import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nt/cubit/location/location_cubit.dart';
import 'package:weather_app_nt/cubit/location/location_state.dart';
import 'package:weather_app_nt/cubit/weather/weather_cubit.dart';
import 'package:weather_app_nt/cubit/weather/weather_state.dart';
import 'package:weather_app_nt/data/models/weather_model.dart';
import 'package:weather_app_nt/service/app_repository.dart';
import 'package:weather_app_nt/ui/app_router.dart';
import 'package:weather_app_nt/utils/constants/route_names.dart';
import 'package:weather_app_nt/utils/size_utils/app_sizes.dart';

import '../ui/splash/splash_screen.dart';

String currentPath = "";
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WeatherCubit(
              WeatherState(
                weatherModel: WeatherModel.initialValue(),
                weeklyWeathers: [],
              ),
            ),
          ),
          BlocProvider(
            create: (_) => LocationCubit(LocationState.initialValue()),
          )
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            height = MediaQuery.sizeOf(context).height;
            width = MediaQuery.sizeOf(context).width;
            ScreenUtil.init(context);
            return MaterialApp(
              navigatorKey: navigatorKey,
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: RouteNames.splash,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
