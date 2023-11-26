part of 'multi_region_cubit.dart';

@immutable
sealed class MultiRegionState {
  final List<CurrentWeatherEntity>? listData;
  final String? message;

  const MultiRegionState({this.listData, this.message});
}

final class MultiRegionInitial extends MultiRegionState {}

final class MultiRegionLoading extends MultiRegionState {}

final class MultiRegionSuccess extends MultiRegionState {
  const MultiRegionSuccess({required super.listData});
}

final class MultiRegionFailure extends MultiRegionState {
  const MultiRegionFailure({super.message});
}
