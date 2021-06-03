import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/components/app_customer/remote/post/all_category_post_response.dart';
import 'package:sahashop_user/components/app_customer/remote/post/all_post_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/all_address_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/cart/cart_response.dart';

import 'package:sahashop_user/components/app_customer/remote/response-request/category/all_category_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/all_message_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/send_message_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/config_ui/app_theme_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/home/home_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/info_customer/info_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/login/login_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/marketing_chanel/combo_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/detail_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/query_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/register/register_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/store/type_store_respones.dart';

part 'customer_service.g.dart';

@RestApi(baseUrl: "https://sahashop.net/api/customer/")
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

  @GET("{storeCode}/products/{idProduct}")
  Future<DetailProductResponse> getDetailProduct(
    @Path() String storeCode,
    @Path() int idProduct,
  );

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

  @GET("{storeCode}/combos")
  Future<CustomerComboResponse> getComboCustomer(@Path() String storeCode);

  @POST("{storeCode}/orders")
  Future<OrdersResponse> createOrder(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @POST("{storeCode}/register")
  Future<RegisterResponse> registerAccount(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @PUT("{storeCode}/profile")
  Future<InfoCustomerResponse> updateAccount(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @POST("{storeCode}/login")
  Future<LoginResponse> loginAccount(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @GET("{storeCode}/profile")
  Future<InfoCustomerResponse> getInfoCustomer(@Path() String storeCode);

  @GET("{storeCode}/messages")
  Future<AllMessageCustomerResponse> getAllMessageCustomer(
    @Path() String storeCode,
    @Query("page") int numberPage,
  );

  @POST("{storeCode}/messages")
  Future<SendMessageCustomerResponse> sendMessageToUser(
    @Path() String storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// cart

  @POST("{storeCode}/carts")
  Future<CartCustomerResponse> getItemCart(@Path() String storeCode);

  @PUT("{storeCode}/carts/items")
  Future<CartCustomerResponse> updateItemCart(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @POST("{storeCode}/carts/items")
  Future<CartCustomerResponse> addItemCart(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  /// address customer

  @GET("{storeCode}/address")
  Future<AllIAddressCustomerResponse> getAllAddressCustomer(
      @Path() String storeCode);
}
