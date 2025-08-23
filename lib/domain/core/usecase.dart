import 'package:dartz/dartz.dart';
import 'package:online_grocery/domain/core/failures.dart';

/// Base class for all use cases

/// UseCase for sync
abstract class UseCase<Result, Params> {
  Either<Failure, Result> call(Params params);
}

/// UseCase for async
abstract class UseCaseAsync<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

/// No params for use cases
class NoParams {}
