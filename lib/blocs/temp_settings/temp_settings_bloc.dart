import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temp_settings_event.dart';
part 'temp_settings_state.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingState> {
  TempSettingsBloc() : super(TempSettingState.initial()) {
    on<ChangeTempunit>((event, emit) {
      emit(
        state.copyWith(
            tempUnit: state.tempUnit == TempUnit.celsius
                ? TempUnit.fahrenheit
                : TempUnit.celsius),
      );
    });
  }
}
