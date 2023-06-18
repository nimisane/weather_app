// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TestModel extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  TestModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

@override
List<Object?> get props => [name, lat, lon, country];

@override
String toString() {
    return 'TestModel{name=$name, lat=$lat, lon=$lon, country=$country}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
