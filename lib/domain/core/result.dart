import 'package:dartz/dartz.dart';
import 'package:online_grocery/domain/core/failures.dart';

/// Defines the type of the result of the use case
/// Either is a type that represents a value of one of two possible types
/// (a success or a failure)
/// [T] is the type of the success value
/// [Failure] is the type of the failure value
/// [ResultEither] is a type that represents a value of one of two possible types
/// [ResultEither<T>] return a value of type [T] or a failure of type [Failure]
/// [typedef] is a keyword in Dart that is used to define a new type
typedef ResultEither<T> = Either<Failure, T>;

/// Defines the type of the result of the use case async
typedef ResultFuture<T> = Future<ResultEither<T>>;
