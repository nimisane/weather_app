// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DirectGeocodingModel extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;

  const DirectGeocodingModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory DirectGeocodingModel.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocodingModel(
        name: data['name'],
        lat: data['lat'],
        lon: data['lon'],
        country: data['country']);
  }

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  String toString() {
    return 'DirectGeocodingModel{name=$name, lat=$lat, lon=$lon, country=$country}';
  }
}
