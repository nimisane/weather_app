import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel(
      {required this.temp,
      required this.description,
      required this.icon,
      required this.tempMin,
      required this.tempMax,
      required this.name,
      required this.country,
      required this.lastUpdated});

  final String description;
  final String icon;
  final double tempMin;
  final double tempMax;
  final String name;
  final double temp;
  final String country;
  final DateTime lastUpdated;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return WeatherModel(
        description: weather['description'],
        icon: weather['icon'],
        tempMin: double.parse(main['temp_min'].toString()),
        tempMax: double.parse(main['temp_max'].toString()),
        temp:  double.parse(main['temp'].toString()),
        name: '',
        country: '',
        lastUpdated: DateTime.now());
  }

  factory WeatherModel.initial() => WeatherModel(
        temp: 100.0,
        description: '',
        icon: '',
        tempMin: 100.0,
        tempMax: 100.0,
        name: '',
        country: '',
        lastUpdated: DateTime(1970),
      );

  @override
  List<Object> get props =>
      [description, icon, temp, tempMin, tempMax, name, country, lastUpdated];

  @override
  String toString() {
    return 'WeatherModel{description=$description, icon=$icon, tempMin=$tempMin, tempMax=$tempMax, temp=$temp, name=$name, country=$country, lastUpdated=$lastUpdated}';
  }

  WeatherModel copyWith(
      {String? description,
      String? icon,
      double? tempMin,
      double? tempMax,
      String? name,
      String? country,
      double? temp,
      DateTime? lastUpdated}) {
    return WeatherModel(
        temp: temp ?? this.temp,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        name: name ?? this.name,
        country: country ?? this.country,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }
}
