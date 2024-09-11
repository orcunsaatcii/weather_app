import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/utils/helper.dart/date_time_converter.dart';
import 'package:weather_app/features/weather/models/daily.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast(
      {super.key, required this.screenWidth, required this.daily});

  final double screenWidth;
  final Daily daily;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: screenWidth * 0.10,
          child: Text(
            DateFormat('EEE').format(
              DateTimeHelper.convertToDateTime(daily.dt!),
            ),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(
          width: 50.0,
        ),
        Image.asset(
          'assets/icons/${daily.weather!.first.icon}.png',
          width: 50,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 30.0,
        ),
        Text(
          daily.weather!.first.main!,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        Text(
          '${daily.temp!.day!.toStringAsFixed(1)}°',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          '${daily.temp!.night!.toStringAsFixed(1)}°',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
