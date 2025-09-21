import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:online_grocery/data/core/dio_failure_mapper.dart';
import 'package:online_grocery/data/core/exceptions.dart';
import 'package:online_grocery/domain/core/failures.dart';

/// Guard for dio exceptions and other exceptions which are not handled by the dio
/// This guard is used to handle the exceptions and return the failure
/// T is the type of the data that is returned by the task
/// Either is used to return the data or the failure
/// task is the function that is called to get the data
/// stackTrace is the stack trace of the exception
/// guardDio is an error handling wrapper function designed to:
/// - catch and map dio exceptions to failures
/// - covert all exceptions to failures following clean architecture principles
/// - return the result as [Either<Failure, T>] type -> to handle errors with function progamming
Future<Either<Failure, T>> guardDio<T>(Future<T> Function() task) async {
  try {
    final data = await task();
    return Right(data);
  } on DioException catch (e) {
    return Left(mapDioExceptionToFailure(e));
  } on UnauthorizedException catch (e, stackTrace) {
    return Left(UnauthorizedFailure(cause: e, stackTrace: stackTrace));
  } on ForbiddenException catch (e, stackTrace) {
    return Left(ForbiddenFailure(cause: e, stackTrace: stackTrace));
  } on CacheException catch (e, stackTrace) {
    return Left(CacheFailure(cause: e, stackTrace: stackTrace));
  } on NetworkException catch (e, stackTrace) {
    return Left(NetworkFailure(cause: e, stackTrace: stackTrace));
  } on NoInternetConnectionException catch (e, stackTrace) {
    return Left(NoInternetConnectionFailure(cause: e, stackTrace: stackTrace));
  } on UnknownException catch (e, stackTrace) {
    return Left(UnknownFailure(cause: e, stackTrace: stackTrace));
  } catch (e, stackTrace) {
    return Left(UnknownFailure(cause: e, stackTrace: stackTrace));
  }
}
