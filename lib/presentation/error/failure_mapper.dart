import 'package:flutter/material.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/domain/core/failures.dart';

/// Maps the failure to a message for the user
/// This is used to show the user a message about the failure
/// This is used in the UI layer
class FailureMapper {
  final BuildContext context;
  const FailureMapper(this.context);

  String mapFailureToMessage(Failure failure) {
    switch (failure) {
      case NetworkFailure():
        return context.appLocalizations.error_network;
      case ServerFailure():
        return context.appLocalizations.error_server;
      case CacheFailure():
        return context.appLocalizations.error_cache;
      case UnauthorizedFailure():
        return context.appLocalizations.error_unauthorized;
      case ForbiddenFailure():
        return context.appLocalizations.error_forbidden;
      case NoInternetConnectionFailure():
        return context.appLocalizations.error_no_internet;
      case UnknownFailure():
        return context.appLocalizations.error_unknown;
      default:
        return context.appLocalizations.error_unknown;
    }
  }
}
