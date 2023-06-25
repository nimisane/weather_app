// import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/constants/constants.dart';
// import 'package:weather_app/cubits/weather/weather_cubit.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  // late final StreamSubscription weatherSubscription;
  // final WeatherCubit weatherCubit;
  // ChangeThemeCubit({required this.weatherCubit})
  //     : super(ChangeThemeState.initial()) {
  //   weatherSubscription = weatherCubit.stream.listen((event) {
  //     if (event.weatherModel.temp > kWarmOrNOt) {
  //       emit(
  //         state.copyWith(appTheme: AppTheme.light),
  //       );
  //     } else {
  //       emit(
  //         state.copyWith(appTheme: AppTheme.dark),
  //       );
  //     }
  //   });
  // }

  // @override
  // Future<void> close() {
  //   weatherSubscription.cancel();
  //   return super.close();
  // }

  ChangeThemeCubit() : super(ChangeThemeState.initial());

  void changeTheme(double temp) {
    if (temp > kWarmOrNOt) {
      emit(
        state.copyWith(appTheme: AppTheme.light),
      );
    } else {
      emit(
        state.copyWith(appTheme: AppTheme.dark),
      );
    }
  }
}
