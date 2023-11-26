import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:weather_app/core/constants/location_constants.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/usecases/usecases.dart';

part 'multi_region_state.dart';

class MultiRegionCubit extends Cubit<MultiRegionState> {
  MultiRegionCubit(
    this._getCurrentWeatherUseCase,
  ) : super(MultiRegionInitial());

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  fetchWeatherOfMultipleRegions() async {
    emit(MultiRegionLoading());
    List<CurrentWeatherEntity> weatherData = [];
    List<Failure> failureList = [];
    for (var param in multiRegionLocations) {
      var res = await _getCurrentWeatherUseCase(param);
      res.fold((l) => failureList.add(l), (r) => weatherData.add(r));
    }
    if (weatherData.isEmpty && failureList.isNotEmpty) {
      emit(MultiRegionFailure(message: failureList.first.message));
    } else {
      emit(MultiRegionSuccess(listData: weatherData));
    }
  }
}
