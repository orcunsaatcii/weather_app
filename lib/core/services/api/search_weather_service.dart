import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/core/services/api/local_weather_service.dart';
import 'package:weather_app/features/weather/models/location.dart';
import 'package:weather_app/features/weather/models/search_location.dart';

class SearchWeatherService {
  final Dio _dio = Dio();
  final String _apiKey = 'YOUR_API_KEY';

  Future<CurrentLocation?> fetchSearchWeather(String city) async {
    final String searchUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';

    try {
      final response = await _dio.get(searchUrl);

      if (response.statusCode == HttpStatus.ok) {
        final locationData = SearchLocation.fromJson(response.data);

        final location = LocalWeatherService().fetchWeatherInfo(
            locationData.coord!.lat!,
            locationData.coord!.lon!,
            locationData.name!);

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
