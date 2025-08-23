import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/domain/core/failures.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';
import 'package:online_grocery/domain/repositories/auth_repository.dart';

@Injectable()
final class UserLoginUsecase
    extends UseCaseAsync<UserLoginEntity, UserLoginSchema> {
  final IAuthRepository _authRepository;

  UserLoginUsecase(this._authRepository);

  @override
  Future<Either<Failure, UserLoginEntity>> call(UserLoginSchema params) {
    return _authRepository.login(params);
  }
}
