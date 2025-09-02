import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/user_info_entity.dart';
import 'package:online_grocery/domain/repositories/auth_repository.dart';

@Injectable()
final class GetUserInfoUsecase extends UseCaseAsync<UserInfoEntity, NoParams> {
  final IAuthRepository _authRepository;

  GetUserInfoUsecase(this._authRepository);

  @override
  ResultFuture<UserInfoEntity> call(NoParams params) {
    return _authRepository.getUserInfo();
  }
}
