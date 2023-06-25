part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  const WeatherState(
      {required this.status,
      required this.weatherModel,
      required this.customError});

  final WeatherStatus status;
  final WeatherModel weatherModel;
  final CustomError customError;

  factory WeatherState.initial() {
    return WeatherState(
        status: WeatherStatus.initial,
        weatherModel: WeatherModel.initial(),
        customError: const CustomError(errorMsg: ''));
  }

  @override
  String toString() {
    return 'WeatherState{status=$status, weatherModel=$weatherModel, customError=$customError}';
  }

  WeatherState copyWith(
      {WeatherStatus? status,
      WeatherModel? weatherModel,
      CustomError? customError}) {
    return WeatherState(
        status: status ?? this.status,
        weatherModel: weatherModel ?? this.weatherModel,
        customError: customError ?? this.customError);
  }

  @override
  List<Object> get props => [status, weatherModel, customError];
}
