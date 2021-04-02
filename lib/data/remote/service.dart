import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/data/remote/response/auth/login_response.dart';

import 'response/auth/register_response.dart';
import 'response/product/product_response.dart';
import 'response/store/all_store_response.dart';
import 'response/store/create_store_response.dart';
import 'response/store/type_store_respones.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://sahavi.vn/api/public/api/")

abstract class SahaService {
  /// Retrofit factory
  factory SahaService(Dio dio) =>
      _SahaService(dio);

  @POST("register")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @POST("login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @GET("store")
  Future<AllStoreResponse> getAllStore();

  @POST("store")
  Future<CreateShopResponse> createStore(@Body() Map<String, dynamic> body);

  @POST("store/{idStore}/products")
  Future<ProductResponse> createProduct(@Path() int idStore, @Body() Map<String, dynamic> body);

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();


}