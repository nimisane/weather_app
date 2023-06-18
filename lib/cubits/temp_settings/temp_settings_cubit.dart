import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TempSettingState> {
  TempSettingsCubit() : super(TempSettingState.initial());

  void toggleTempUnit() {
    emit(
      state.copyWith(
          tempUnit: TempUnit.celsius == state.tempUnit
              ? TempUnit.fahrenheit
              : TempUnit.celsius),
    );
  }
}
