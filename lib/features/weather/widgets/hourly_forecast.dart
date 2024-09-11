import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/utils/helper.dart/date_time_converter.dart';
import 'package:weather_app/features/weather/models/hourly.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key, required this.hourly});

  final Hourly hourly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/icons/${hourly.weather!.first.icon}.png',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            '${hourly.temp!.toStringAsFixed(1)}°',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            DateFormat.jm()
                .format(DateTimeHelper.convertToDateTime(hourly.dt!)),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
