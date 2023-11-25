part of 'multi_region_cubit.dart';

@immutable
sealed class MultiRegionState {
  final List<CurrentWeatherEntity>? listData;

  const MultiRegionState({this.listData});
}

final class MultiRegionInitial extends MultiRegionState {}

final class MultiRegionLoading extends MultiRegionState {}

final class MultiRegionSuccess extends MultiRegionState {
  const MultiRegionSuccess({required super.listData});
}

final class MultiRegionFailure extends MultiRegionState {
  final String? message;

  const MultiRegionFailure(this.message);
}
