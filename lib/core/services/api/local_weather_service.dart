import 'dart:io';

import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/services/location/current_location_service.dart';
import 'package:weather_app/features/weather/models/location.dart';

class LocalWeatherService {
  final Dio _dio = Dio();
  final String _apiKey = 'YOUR_API_KEY';

  Future<CurrentLocation?> fetchUsersLocationWeather() async {
    final LocationData? locationData =
        await LocationService.getCurrentLocation();

    if (locationData == null) {
      return null;
    }

    String url =
        'https://api.openweathermap.org/data/3.0/onecall?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$_apiKey&units=metric';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == HttpStatus.ok) {
        CurrentLocation location = CurrentLocation.fromJson(response.data);
        location.timezone = response.data['timezone'] as String;
        return location;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print('Request error: ${e.message}');
      return null;
    }
  }

  Future<CurrentLocation?> fetchWeatherInfo(
      double lat, double lon, String timezone) async {
    String url =
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == HttpStatus.ok) {
        CurrentLocation location = CurrentLocation.fromJson(response.data);
        location.timezone = timezone;
        return location;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print('Request error: ${e.message}');
      return null;
    }
  }
}
