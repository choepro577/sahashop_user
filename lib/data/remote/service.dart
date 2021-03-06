import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/data/remote/response/auth/login_response.dart';
import 'package:sahashop_user/data/remote/response/config_ui/app_theme_response.dart';
import 'package:sahashop_user/data/remote/response/config_ui/create_app_theme_response.dart';

import 'response/auth/register_response.dart';
import 'response/category/all_category_response.dart';
import 'response/category/create_category_response.dart';
import 'response/device_token/device_token_user_response.dart';
import 'response/image/upload_image_response.dart';
import 'response/product/all_product_response.dart';
import 'response/product/product_response.dart';
import 'response/store/all_store_response.dart';
import 'response/store/create_store_response.dart';
import 'response/store/type_store_respones.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://stkvip.net/api/public/api/")
abstract class SahaService {
  /// Retrofit factory
  factory SahaService(Dio dio) => _SahaService(dio);

  @POST("register")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @POST("login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @GET("store")
  Future<AllStoreResponse> getAllStore();

  @POST("store")
  Future<CreateShopResponse> createStore(@Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/products")
  Future<ProductResponse> createProduct(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/products")
  Future<AllProductResponse> getAllProduct(
      @Path() String storeCode,
      @Query("search") String search,
      @Query("idCategory") String idCategory,
      @Query("descending") bool descending,
      @Query("details") String details,
      @Query("sortBy") String sortBy);

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @POST("store/{storeCode}/categories")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> createCategory(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @POST("app-theme/{storeCode}")
  Future<CreateAppThemeResponse> createAppTheme(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @GET("app-theme/{storeCode}")
  Future<GetAppThemeResponse> getAppTheme(@Path() String storeCode);

  @GET("store/{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(@Path() String storeCode);

  @POST("images")
  Future<UploadImageResponse> uploadImage(@Body() Map<String, dynamic> body);

  @POST("device_token_user")
  Future<UpdateDeviceTokenResponse> updateDeviceTokenUser(
      @Body() Map<String, dynamic> body);
}
