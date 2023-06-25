import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/repositories/weather_repository.dart';

import '../../models/customError.dart';
import '../../models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({
    required this.weatherRepository,
  }) : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  Future<void> _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final WeatherModel weatherModel =
          await weatherRepository.fetchWeather(event.city);

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
