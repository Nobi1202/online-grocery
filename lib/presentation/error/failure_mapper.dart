import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/domain/core/failures.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';

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
        _handleUnauthorizedFailure();
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

  /// Handles unauthorized failure by triggering logout and navigation
  /// This method is called automatically when UnauthorizedFailure is encountered
  void _handleUnauthorizedFailure() {
    // Execute logout and navigation in the next frame to avoid issues during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(RouteName.login);
    });
  }
}
