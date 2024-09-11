import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/providers/page_control_provider.dart';
import 'package:weather_app/features/weather/models/location.dart';
import 'package:weather_app/features/weather/view_models/weather_view_model.dart';
import 'package:weather_app/features/weather/widgets/custom_search_bar.dart';
import 'package:weather_app/features/weather/widgets/weather_info.dart';
import 'package:weather_app/features/weather/view_models/search_weather_view_model.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final localWeatherAsyncValue = ref.watch(localWeatherViewModelProvider);
    final searchWeatherAsyncValue = ref.watch(searchWeatherViewModelProvider);
    final isLocalWeatherSelected = ref.watch(pageControlProvider);
    final searchController = TextEditingController();

    Widget buildWeatherInfo(AsyncValue<CurrentLocation?> weatherData) {
      return weatherData.when(
        data: (location) {
          if (location != null) {
            return WeatherInfo(location: location);
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
        error: (error, stackTrace) => Center(
          child: Text(
            'City not found',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundColor1,
              AppColors.backgroundColor2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  CustomSearchBar(
                    searchController: searchController,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildWeatherInfo(
                    isLocalWeatherSelected
                        ? localWeatherAsyncValue
                        : searchWeatherAsyncValue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
