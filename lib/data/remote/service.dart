import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/data/remote/response/auth/login_response.dart';
import 'package:sahashop_user/data/remote/response/config_ui/app_theme_response.dart';
import 'package:sahashop_user/data/remote/response/config_ui/create_app_theme_response.dart';

import 'response/auth/register_response.dart';
import 'response/category/all_category_response.dart';
import 'response/category/create_category_response.dart';
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

  @POST("store/{idStore}/products")
  Future<ProductResponse> createProduct(
      @Path() int idStore, @Body() Map<String, dynamic> body);

  @GET("store/{idStore}/products")
  Future<AllProductResponse> getAllProduct(@Path() int idStore);

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @POST("store/{idStore}/categories")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> createCategory(
      @Path() int idStore, @Body() Map<String, dynamic> body);

  @POST("app-theme/{idStore}")
  Future<CreateAppThemeResponse> createAppTheme(
      @Path() int idStore, @Body() Map<String, dynamic> body);

  @GET("app-theme/{idStore}")
  Future<GetAppThemeResponse> getAppTheme(@Path() int idStore);

  @GET("store/{idStore}/categories")
  Future<AllCategoryResponse> getAllCategory(@Path() int idStore);

  @POST("images")
  Future<UploadImageResponse> uploadImage(@Body() Map<String, dynamic> body);
}
