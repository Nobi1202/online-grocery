import 'package:online_grocery/domain/core/failures.dart';

/// Maps the failure to a message for the user
/// This is used to show the user a message about the failure
/// This is used in the UI layer
class FailureMapper {
  const FailureMapper();

  String mapFailureToMessage(Failure failure) {
    switch (failure) {
      case NetworkFailure():
        return 'Network failure';
      case ServerFailure():
        return 'Server failure';
      case CacheFailure():
        return 'Cache failure';
      case UnauthorizedFailure():
        return 'Unauthorized failure';
      case ForbiddenFailure():
        return 'Forbidden failure';
      case NoInternetConnectionFailure():
        return 'No internet connection';
      case UnknownFailure():
        return 'Unknown failure';
      default:
        return 'Unknown failure';
    }
  }
}
