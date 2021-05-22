import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/components/app_customer/remote/post/all_category_post_response.dart';
import 'package:sahashop_user/components/app_customer/remote/post/all_post_response.dart';

import 'package:sahashop_user/components/app_customer/remote/response-request/category/all_category_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/config_ui/app_theme_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/home/home_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/query_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/store/type_store_respones.dart';

part 'customer_service.g.dart';

@RestApi(baseUrl: "https://sahashop.net/api/public/api/customer/")
abstract class CustomerService {
  /// Retrofit factory
  factory CustomerService(Dio dio) => _CustomerService(dio);

  @GET("store")
  Future<AllStoreResponse> getAllStore();

  @GET("store/{storeCode}/products")
  Future<AllProductResponse> getAllProduct(@Path() String storeCode);

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @GET("{storeCode}/app-theme")
  Future<GetAppThemeResponse> getAppTheme(@Path() String storeCode);

  @GET("{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(@Path() String storeCode);

  @GET("{storeCode}/products")
  Future<QueryProductResponse> getProductWithCategory(
      @Path() String storeCode, int idCategory);

  @GET("{storeCode}/products?=")
  Future<QueryProductResponse> searchProduct(
      @Path() String storeCode,
      @Query("search") String search,
      @Query("category_ids") String idCategory,
      @Query("descending") bool descending,
      @Query("details") String details,
      @Query("sort_by") String sortBy);

  @GET("{storeCode}/post_categories")
  Future<AllCategoryPostResponse> getAllCategoryPost(@Path() String storeCode);

  @GET("{storeCode}/posts?=")
  Future<AllPostResponse> searchPost(
      @Path() String storeCode,
      @Query("search") String search,
      @Query("category_ids") String idCategory,
      @Query("descending") bool descending,
      @Query("sort_by") String sortBy);

  @GET("{storeCode}/home_app")
  Future<HomeResponse> getHomeApp(@Path() String storeCode);

  @POST("{storeCode}/orders")
  Future<OrdersResponse> createOrder(
      @Path() String storeCode, @Body() Map<String, dynamic> body);
}
