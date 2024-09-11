import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/services/api/search_weather_service.dart';
import 'package:weather_app/features/weather/models/location.dart';

class SearchWeatherViewModel
    extends StateNotifier<AsyncValue<CurrentLocation?>> {
  final SearchWeatherService _searchWeatherService;

  SearchWeatherViewModel(this._searchWeatherService)
      : super(
          const AsyncValue.loading(),
        );

  Future<void> fetchSearchWeather(String city) async {
    state = const AsyncValue.loading();
    try {
      final location = await _searchWeatherService.fetchSearchWeather(city);

      if (location != null) {
        state = AsyncValue.data(location);
      } else {
        state =
            const AsyncValue.error('Failed to load location', StackTrace.empty);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e.toString(), stackTrace);
    }
  }
}

final searchWeatherServiceProvider = Provider(
  (ref) => SearchWeatherService(),
);

final searchWeatherViewModelProvider =
    StateNotifierProvider<SearchWeatherViewModel, AsyncValue<CurrentLocation?>>(
  (ref) {
    final searchWeatherService = ref.watch(searchWeatherServiceProvider);
    return SearchWeatherViewModel(searchWeatherService);
  },
);
