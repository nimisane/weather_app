import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/repositories/weather_repository.dart';

import '../../models/customError.dart';
import '../../models/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.initial));

    try {
      emit(
        state.copyWith(status: WeatherStatus.loading),
      );
      final WeatherModel weatherModel =
          await weatherRepository.fetchWeather(city);

      emit(
        state.copyWith(
            status: WeatherStatus.loaded, weatherModel: weatherModel),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(status: WeatherStatus.error, customError: e),
      );
    }
  }
}
