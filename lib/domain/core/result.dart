import 'package:dartz/dartz.dart';
import 'package:online_grocery/domain/core/failures.dart';

/// Defines the type of the result of the use case
typedef ResultEither<T> = Either<Failure, T>;

/// Defines the type of the result of the use case async
typedef ResultFuture<T> = Future<ResultEither<T>>;
