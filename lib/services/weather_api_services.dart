import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/exceptions/weather_exceptions.dart';
import 'package:weather_app/models/direct_geocoding_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/http_error_handler.dart';

class WeatherApiServices {
  WeatherApiServices({required this.httpClient});
  final http.Client httpClient;

  Future<DirectGeocodingModel> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'http',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody.isEmpty) {
          throw WeatherExceptions('Cannot get the location of $city');
        }

        final directGeocoding = DirectGeocodingModel.fromJson(responseBody);

        print(directGeocoding.country);
        return directGeocoding;
      } else {
        throw httpErrorHandler(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherModel> getWeather(
      DirectGeocodingModel directGeocodingModel) async {
    final uri = Uri(
        scheme: 'http',
        host: kApiHost,
        path: '/data/2.5/weather',
        queryParameters: {
          'lat': '${directGeocodingModel.lat}',
          'lon': '${directGeocodingModel.lon}',
          'units': kunit,
          'appid': dotenv.env['APPID'],
        });

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final weather = json.decode(response.body);

      if (weather.isEmpty) {
        throw WeatherExceptions('Unable to get weather data');
      }

      final WeatherModel weatherModel = WeatherModel.fromJson(weather);

      return weatherModel;
    } catch (e) {
      rethrow;
    }
  }
}
