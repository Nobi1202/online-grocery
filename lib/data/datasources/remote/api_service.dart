import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/data/models/response/cart_detail_dto.dart';
import 'package:online_grocery/data/models/response/category_dto.dart';
import 'package:online_grocery/data/models/response/product_category_detail_dto.dart';
import 'package:online_grocery/data/models/response/user_info_dto.dart';
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

  @GET('/auth/me')
  Future<UserInfoDto> getUserInfo();

  @GET('/carts/user/{id}')
  Future<CartDetailDto> getCartItems(@Path('id') int id);

  @GET('/carts/{id}')
  Future<SingleCartDetailDto> getFavoriteItems(@Path('id') int id);

  @GET('/products/categories')
  Future<List<CategoryDto>> getAllProductCategories();

  @GET('/products/category/{category}')
  Future<ProductCategoryDetailDto> getProductsByCategory(
    @Path('category') String category,
  );
}
