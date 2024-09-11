import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/colors.dart';

class TempWindHum extends StatelessWidget {
  const TempWindHum(
      {super.key,
      required this.icon,
      required this.color,
      required this.value,
      required this.label});

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.white,
              ),
        ),
      ],
    );
  }
}
