import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/utils/helper.dart/date_time_converter.dart';
import 'package:weather_app/features/weather/models/location.dart';
import 'package:weather_app/features/weather/view_models/time_view_model.dart';
import 'package:weather_app/features/weather/widgets/daily_forecast.dart';
import 'package:weather_app/features/weather/widgets/hourly_forecast.dart';
import 'package:weather_app/features/weather/widgets/temp_wind_hum.dart';

class WeatherInfo extends ConsumerWidget {
  const WeatherInfo({super.key, required this.location});

  final CurrentLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Text(
          location.timezone!,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Image.asset(
          'assets/icons/${location.current!.weather!.first.icon}.png',
          fit: BoxFit.cover,
          width: 200,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Consumer(
          builder: (context, ref, child) {
            final time = ref.watch(timerProvider);
            final date = ref.watch(DateTimeHelper().dateProvider);
            return Text(
              '${DateTimeHelper.showCurrentDateTime(date)} | ${DateTimeHelper.convertTime(time)}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            );
          },
        ),
        const SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TempWindHum(
                  icon: Ionicons.thermometer_outline,
                  color: Colors.orange,
                  value: '${location.current!.temp!.toStringAsFixed(1)}°',
                  label: 'Temp'),
              TempWindHum(
                icon: CupertinoIcons.wind,
                color: Colors.blue,
                value:
                    '${location.current!.windSpeed!.toStringAsFixed(1)} km/h',
                label: 'Wind',
              ),
              TempWindHum(
                icon: Ionicons.water,
                color: Colors.lightBlueAccent,
                value: '${location.current!.humidity!}%',
                label: 'Humidity',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.secondaryColor,
            border: Border.all(
              color: AppColors.white,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HOURLY',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: screenHeight * 0.15,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: location.daily!.length - 1,
                  itemBuilder: (context, index) {
                    return HourlyForecast(
                      hourly: location.hourly![index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '8-DAY FORECAST',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.white,
          thickness: 0.2,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return DailyForecast(
              screenWidth: screenWidth,
              daily: location.daily![index],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 25.0,
          ),
          itemCount: location.daily!.length,
        ),
      ],
    );
  }
}
