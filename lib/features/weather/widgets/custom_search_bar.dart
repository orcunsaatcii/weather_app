import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/providers/page_control_provider.dart';
import 'package:weather_app/features/weather/view_models/search_weather_view_model.dart';

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () => _onSearchPressed(context, ref),
                icon: const Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              fillColor: AppColors.backgroundColor1,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.white,
                ),
            cursorColor: AppColors.white,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        InkWell(
          onTap: () => _onLocationPressed(ref),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 16.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.backgroundColor1,
              border: Border.all(
                color: AppColors.white,
              ),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _onSearchPressed(BuildContext context, WidgetRef ref) {
    final city = searchController.text.trim();
    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a city name'),
        ),
      );
      return;
    }

    ref.read(searchWeatherViewModelProvider.notifier).fetchSearchWeather(city);

    ref.read(pageControlProvider.notifier).setSearchMode();
  }

  void _onLocationPressed(WidgetRef ref) {
    ref.read(pageControlProvider.notifier).setLocalMode();
  }
}
