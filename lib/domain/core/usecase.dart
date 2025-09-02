import 'package:online_grocery/domain/core/result.dart';

/// Base class for all use cases

/// UseCase for sync
abstract class UseCase<Result, Params> {
  ResultEither<Result> call(Params params);
}

/// UseCase for async
abstract class UseCaseAsync<Result, Params> {
  ResultFuture<Result> call(Params params);
}

/// No params for use cases
class NoParams {}
