import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/error/error.dart';

abstract class LocationDataSource {
  Future<Either<Failure, LocationData>> getLocalLocationData();
}

class LocationDataSourceImpl implements LocationDataSource {
  final Location _location;

  LocationDataSourceImpl(this._location);
  @override
  Future<Either<Failure, LocationData>> getLocalLocationData() async {
    if (await _location.serviceEnabled()) {
      var permissionStatus = await _location.requestPermission();
      if (permissionStatus == PermissionStatus.granted) {
        var locationData = await _location.getLocation();
        return Right(locationData);
      }
      return Left(
          PermissionFailure(message: 'Permission ${permissionStatus.name}'));
    }
    return const Left(OtherFailure(message: 'Location service not enabled'));
  }
}
