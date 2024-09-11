import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/services/api/local_weather_service.dart';
import 'package:weather_app/features/weather/models/location.dart';

class LocalWeatherViewModel
    extends StateNotifier<AsyncValue<CurrentLocation?>> {
  final LocalWeatherService _localWeatherService;

  LocalWeatherViewModel(this._localWeatherService)
      : super(const AsyncValue.loading()) {
    fetchLocalWeather();
  }

  Future<void> fetchLocalWeather() async {
    try {
      final location = await _localWeatherService.fetchUsersLocationWeather();
      if (location != null) {
        state = AsyncValue.data(location);
      } else {
        state =
            const AsyncValue.error('Failed to load location', StackTrace.empty);
      }
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.empty);
    }
  }

  void fetchUsersLocationWeather() {}
}

final localWeatherServiceProvider = Provider(
  (ref) => LocalWeatherService(),
);

final localWeatherViewModelProvider =
    StateNotifierProvider<LocalWeatherViewModel, AsyncValue<CurrentLocation?>>(
        (ref) {
  final localWeatherService = ref.watch(localWeatherServiceProvider);
  return LocalWeatherViewModel(localWeatherService);
});
