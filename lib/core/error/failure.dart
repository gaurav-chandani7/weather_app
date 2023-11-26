abstract class Failure {
  final String? message;
  const Failure({this.message});
}

class NoInternetFailure extends Failure {
  NoInternetFailure({
    super.message =
        'No Internet Connection. \nPlease make sure you have a stable connection.',
  });
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class NoDataFailure extends Failure {}

class CacheFailure extends Failure {}

class PermissionFailure extends Failure {
  PermissionFailure({super.message});
}

class OtherFailure extends Failure {
  const OtherFailure({super.message});
}
