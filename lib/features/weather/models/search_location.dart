import 'package:weather_app/features/weather/models/coord.dart';

class SearchLocation {
  Coord? coord;
  String? name;

  SearchLocation({
    this.coord,
    this.name,
  });

  factory SearchLocation.fromJson(Map<String, dynamic> json) {
    return SearchLocation(
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
      };
}
