import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/data/models/response/user_login_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
@lazySingleton
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<UserLoginDto> login(@Body() UserLoginSchema userLoginSchema);
}
