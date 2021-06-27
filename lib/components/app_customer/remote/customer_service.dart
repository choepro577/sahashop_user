import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/components/app_customer/remote/post/all_category_post_response.dart';
import 'package:sahashop_user/components/app_customer/remote/post/all_post_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/all_address_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/create_update_address_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/delete_address_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/category/all_category_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/all_message_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/chat_customer/send_message_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/config_ui/app_theme_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/favorite/all_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/favorite/favorite_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/home/home_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/info_customer/info_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/login/login_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/marketing_chanel/combo_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/marketing_chanel/voucher_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/cancel_order_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_history_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/state_history_order_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/payment_customer/payment_method_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/detail_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/query_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/register/register_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/review/review_of_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/review/review_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/shipment/shipment_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/store/type_store_respones.dart';
import 'package:sahashop_user/model/cart.dart';

part 'customer_service.g.dart';

@RestApi(baseUrl: "http://ashop.sahavi.vn/api/customer/")
abstract class CustomerService {
  /// Retrofit factory
  factory CustomerService(Dio dio) => _CustomerService(dio);

  @GET("store")
  Future<AllStoreResponse> getAllStore();

  @GET("store/{storeCode}/products")
  Future<AllProductResponse> getAllProduct(@Path("storeCode") String storeCode);

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @GET("{storeCode}/app-theme")
  Future<GetAppThemeResponse> getAppTheme(@Path("storeCode") String? storeCode);

  @GET("{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(
      @Path("storeCode") String? storeCode);

  @GET("{storeCode}/products")
  Future<QueryProductResponse> getProductWithCategory(
      @Path("storeCode") String storeCode, int idCategory);

  @GET("{storeCode}/products?=")
  Future<QueryProductResponse> searchProduct(
      @Path("storeCode") String? storeCode,
      @Query("search") String search,
      @Query("category_ids") String idCategory,
      @Query("descending") bool descending,
      @Query("details") String details,
      @Query("sort_by") String sortBy);

  @GET("{storeCode}/products/{idProduct}")
  Future<DetailProductResponse> getDetailProduct(
    @Path("storeCode") String? storeCode,
    @Path() int? idProduct,
  );

  @GET("{storeCode}/post_categories")
  Future<AllCategoryPostResponse> getAllCategoryPost(
      @Path("storeCode") String? storeCode);

  @GET("{storeCode}/posts?=")
  Future<AllPostResponse> searchPost(
      @Path("storeCode") String? storeCode,
      @Query("search") String search,
      @Query("category_ids") String idCategory,
      @Query("descending") bool descending,
      @Query("sort_by") String sortBy);

  @GET("{storeCode}/home_app")
  Future<HomeResponse> getHomeApp(@Path("storeCode") String? storeCode);

  @POST("{storeCode}/carts/orders")
  Future<OrderResponse> createOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("{storeCode}/register")
  Future<RegisterResponse> registerAccount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("{storeCode}/profile")
  Future<InfoCustomerResponse> updateAccount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("{storeCode}/login")
  Future<LoginResponse> loginAccount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("{storeCode}/profile")
  Future<InfoCustomerResponse> getInfoCustomer(
      @Path("storeCode") String? storeCode);

  /// marketing chanel

  @GET("{storeCode}/combos")
  Future<CustomerComboResponse> getComboCustomer(
      @Path("storeCode") String? storeCode);

  @GET("{storeCode}/vouchers")
  Future<VoucherCustomerResponse> getVoucherCustomer(
      @Path("storeCode") String? storeCode);

  /// chat customer

  @GET("{storeCode}/messages")
  Future<AllMessageCustomerResponse> getAllMessageCustomer(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
  );

  @POST("{storeCode}/messages")
  Future<SendMessageCustomerResponse> sendMessageToUser(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// cart

  @POST("{storeCode}/carts")
  Future<Cart> getItemCart(@Path("storeCode") String? storeCode);

  @POST("{storeCode}/carts")
  Future<Cart> addVoucherCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("{storeCode}/carts/items")
  Future<Cart> updateItemCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("{storeCode}/carts/items")
  Future<Cart> addItemCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  /// address customer

  @GET("{storeCode}/address")
  Future<AllIAddressCustomerResponse> getAllAddressCustomer(
      @Path("storeCode") String? storeCode);

  @POST("{storeCode}/address")
  Future<CreateUpdateAddressCustomerResponse> createAddressCustomer(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("{storeCode}/address/{idAddressCustomer}")
  Future<CreateUpdateAddressCustomerResponse> updateAddressCustomer(
      @Path("storeCode") String? storeCode,
      @Path() int? idAddressCustomer,
      @Body() Map<String, dynamic> body);

  @DELETE("{storeCode}/address/{idAddressCustomer}")
  Future<DeleteAddressCustomerResponse> deleteAddressCustomer(
      @Path("storeCode") String? storeCode, @Path() int? idAddressCustomer);

  /// shipment

  @POST("{storeCode}/shipment/fee")
  Future<ShipmentCustomerResponse> chargeShipmentFee(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  /// payment
  @GET("{storeCode}/payment_methods")
  Future<PaymentMethodCustomerResponse> getPaymentMethod(
      @Path("storeCode") String? storeCode);

  /// order history

  @GET("{storeCode}/carts/orders")
  Future<OrderHistoryResponse> getOrderHistory(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
    @Query("search") String search,
    @Query("field_by") String fieldBy,
    @Query("field_by_value") String filterByValue,
    @Query("sort_by") String sortBy,
    @Query("descending") String descending,
    @Query("date_from") String dateFrom,
    @Query("date_to") String dateTo,
  );

  @GET("{storeCode}/carts/orders/{orderCode}")
  Future<OrderResponse> getOneOrderHistory(
      @Path("storeCode") String? storeCode, @Path() String? orderCode);

  @GET("{storeCode}/carts/orders/status_records/{idOrder}")
  Future<StateHistoryOrderCustomerResponse> getStateHistoryCustomerOrder(
    @Path("storeCode") String? storeCode,
    @Path() int? idOrder,
  );

  @POST("{storeCode}/carts/orders/cancel")
  Future<CancelOrderResponse> cancelOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("{storeCode}/carts/orders/change_payment_method/{orderCode}")
  Future<CancelOrderResponse> changePaymentMethod(
      @Path("storeCode") String? storeCode,
      @Body() Map<String, dynamic> body,
      @Path() String? orderCode);

  @GET("{storeCode}/favorites")
  Future<AllProductFavorites> getAllFavorite(
      @Path("storeCode") String storeCode, @Path("page") int page);

  @POST("{storeCode}/products/{productId}/favorites")
  Future<FavoriteResponse> favoriteProduct(@Path("storeCode") String storeCode,
      @Path("productId") int productId, @Body() Map<String, dynamic> body);

  /// review
  @POST("{storeCode}/products/{idProduct}/reviews")
  Future<ReviewResponse> review(@Path("storeCode") String? storeCode,
      @Path() int? idProduct, @Body() Map<String, dynamic> body);

  @GET("{storeCode}/products/{idProduct}/reviews")
  Future<ReviewOfProResponse> getReviewProduct(
    @Path("storeCode") String? storeCode,
    @Path() int? idProduct,
    @Query("filter_by") String filterBy,
    @Query("filter_by_value") String filterByValue,
    @Query("has_image") bool? hasImage,
  );
}
