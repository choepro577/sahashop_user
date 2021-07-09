import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/app_customer/const/env.dart';
import 'package:sahashop_user/app_customer/remote/response-request/orders/order_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/address/add_token_shipment_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/address/address_respone.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/address/all_address_store_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/address/all_shipment_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/address/create_address_store_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/address/delete_address_store_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/attributes/attributes_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/auth/check_exists_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/auth/login_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/chat/all_chat_customer_reponse.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/chat/all_message_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/config_ui/app_theme_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/config_ui/create_app_theme_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/customer/all_customer_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/combo/create_combo_reponse.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/combo/end_combo_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/combo/my_combo_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/discount/create_discount_respone.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/discount/end_discount_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/voucher/create_voucher_reponse.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/delete_program_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/discount/my_program_reponse.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/voucher/end_voucher_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/voucher/my_voucher_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/order/all_order_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/order/change_order_status_repose.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/order/change_pay_success_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/order/state_history_order_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/payment_method/payment_method_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/payment_method/update_payment_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/post/all_post_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/report/product_report_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/report/report_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/review_manage/all_review_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/review_manage/review_delete_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/review_manage/update_review_response.dart';

import 'response-request/auth/register_response.dart';
import 'response-request/category/all_category_response.dart';
import 'response-request/category/create_category_response.dart';
import 'response-request/category/delete_category_response.dart';
import 'response-request/device_token/device_token_user_response.dart';
import 'response-request/image/upload_image_response.dart';
import 'response-request/post/all_category_post_response.dart';
import 'response-request/post/create_category_post_response.dart';
import 'response-request/post/create_post_response.dart';
import 'response-request/post/delete_category_post_response.dart';
import 'response-request/post/delete_post_response.dart';
import 'response-request/post/update_category_post_response.dart';
import 'response-request/product/all_product_response.dart';
import 'response-request/product/product_delete_response.dart';
import 'response-request/product/product_response.dart';
import 'response-request/store/all_store_response.dart';
import 'response-request/store/create_store_response.dart';
import 'response-request/store/type_store_respones.dart';
import 'response-request/success/success_response.dart';

part 'service.g.dart';

@RestApi(baseUrl: "$DOMAIN_API_CUSTOMER/api/")
abstract class SahaService {
  /// Retrofit factory
  factory SahaService(Dio dio) => _SahaService(dio);

  @POST("register")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @POST("login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @POST("login/check_exists")
  Future<ExistsLoginResponse> checkExists(@Body() Map<String, dynamic> body);

  @POST("reset_password")
  Future<SuccessResponse> resetPassword(@Body() Map<String, dynamic> body);

  @POST("change_password")
  Future<SuccessResponse> changePassword(@Body() Map<String, dynamic> body);

  @GET("store")
  Future<AllStoreResponse> getAllStore();

  @POST("store")
  Future<CreateShopResponse> createStore(@Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/products")
  Future<ProductResponse> createProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/products/{idProduct}")
  Future<ProductResponse> updateProduct(@Path("storeCode") String? storeCode,
      @Path() int? idProduct, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/products/{idProduct}")
  Future<ProductDeleteResponse> deleteProduct(
      @Path("storeCode") String? storeCode, @Path() int? idProduct);

  @GET("store/{storeCode}/products")
  Future<AllProductResponse> getAllProduct(
    @Path("storeCode") String? storeCode,
    @Query("search") String search,
    @Query("category_ids") String idCategory,
    @Query("descending") bool descending,
    @Query("status") String status,
    @Query("filter_by") String filterBy,
    @Query("filter_option") String filterOption,
    @Query("filter_by_value") String filterByValue,
    @Query("details") String details,
    @Query("sort_by") String sortBy,
    @Query("page") int page,
  );

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @POST("store/{storeCode}/categories")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> createCategory(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/categories/{categoryId}")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> updateCategory(
      @Path("storeCode") String? storeCode,
      @Path("categoryId") int? categoryId,
      @Body() Map<String, dynamic> body);

  @POST("app-theme/{storeCode}")
  Future<CreateAppThemeResponse> createAppTheme(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("app-theme/{storeCode}")
  Future<GetAppThemeResponse> getAppTheme(@Path("storeCode") String? storeCode);

  @GET("store/{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(
      @Path("storeCode") String? storeCode);

  @DELETE("store/{storeCode}/categories/{categoryId}")
  Future<CategoryDeleteResponse> deleteCategory(
      @Path("storeCode") String? storeCode,
      @Path("categoryId") int? categoryId);

  @POST("images")
  Future<UploadImageResponse> uploadImage(@Body() Map<String, dynamic> body);

  @POST('store/{storeCode}/discounts')
  Future<CreateDiscountResponse> createDiscount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("device_token_user")
  Future<UpdateDeviceTokenResponse> updateDeviceTokenUser(
      @Body() Map<String, dynamic> body);

  /// post

  @POST("store/{storeCode}/post_categories")
  @FormUrlEncoded()
  Future<CreateCategoryPostResponse> createCategoryPost(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/post_categories")
  Future<AllCategoryPostResponse> getAllCategoryPost(
      @Path("storeCode") String? storeCode);

  @DELETE("store/{storeCode}/post_categories/{categoryPostId}")
  Future<CategoryPostDeleteResponse> deleteCategoryPost(
    @Path("storeCode") String? storeCode,
    @Path("categoryPostId") int? categoryPostId,
  );

  @POST("store/{storeCode}/post_categories/{categoryPostId}")
  Future<UpdateCategoryPostResponse> updateCategoryPost(
      @Path("storeCode") String? storeCode,
      @Path("categoryPostId") int? categoryPostId,
      @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/posts")
  @FormUrlEncoded()
  Future<CreatePostResponse> createPost(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/posts/{postId}")
  Future<CreatePostResponse> updatePost(@Path("storeCode") String? storeCode,
      @Path("postId") int? postId, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/posts/{postId}")
  Future<DeletePostResponse> deletePost(
    @Path("storeCode") String? storeCode,
    @Path("postId") int? postId,
  );

  @GET("store/{storeCode}/posts")
  Future<AllPostResponse> getAllPost(@Path("storeCode") String? storeCode,
      @Query("page") int page, @Query("search") String search);

  @GET("store/{storeCode}/discounts")
  Future<MyProgramResponse> getAllDisCount(
      @Path("storeCode") String? storeCode);

  @GET("store/{storeCode}/vouchers")
  Future<MyVoucherResponse> getAllVoucher(@Path("storeCode") String? storeCode);

  @GET("store/{storeCode}/combos")
  Future<MyComboResponse> getAllCombo(@Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/discounts/{idDiscount}")
  Future<MyProgramResponse> updateDiscount(@Path("storeCode") String? storeCode,
      @Path() int? idDiscount, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/discounts/{idDiscount}")
  Future<DeleteProgramResponse> deleteDiscount(
      @Path("storeCode") String? storeCode, @Path() int? idDiscount);

  @DELETE("store/{storeCode}/vouchers/{idVoucher}")
  Future<DeleteProgramResponse> deleteVoucher(
      @Path("storeCode") String? storeCode, @Path() int? idVoucher);

  @DELETE("store/{storeCode}/combos/{idCombo}")
  Future<DeleteProgramResponse> deleteCombo(
      @Path("storeCode") String? storeCode, @Path() int? idCombo);

  @POST("store/{storeCode}/vouchers")
  Future<CreateVoucherResponse> createVoucher(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/vouchers/{idVoucher}")
  Future<CreateVoucherResponse> updateVoucher(
      @Path("storeCode") String? storeCode,
      @Path() int? idVoucher,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/vouchers_end")
  Future<EndVoucherResponse> getEndVoucherFromPage(
      @Path("storeCode") String? storeCode, @Query("page") int numberPage);

  @GET("store/{storeCode}/discounts_end")
  Future<EndDiscountResponse> getEndDiscountFromPage(
      @Path("storeCode") String? storeCode, @Query("page") int numberPage);

  @GET("store/{storeCode}/combos_end")
  Future<EndComboResponse> getEndComboFromPage(
      @Path("storeCode") String? storeCode, @Query("page") int numberPage);

  @POST("store/{storeCode}/combos")
  Future<CreateComboResponse> createCombo(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/combos/{idCombo}")
  Future<CreateComboResponse> updateCombo(@Path("storeCode") String? storeCode,
      @Path() int? idCombo, @Body() Map<String, dynamic> body);

  @GET("place/vn/province")
  Future<AddressResponse> getProvince();

  @GET("place/vn/district/{idProvince}")
  Future<AddressResponse> getDistrict(@Path() int? idProvince);

  @GET("place/vn/wards/{idDistrict}")
  Future<AddressResponse> getWard(@Path() int? idDistrict);

  @POST("store/{storeCode}/store_address")
  Future<CreateAddressStoreResponse> createAddressStore(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/store_address")
  Future<AllAddressStoreResponse> getAllAddressStore(
      @Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/store_address/{idAddressStore}")
  Future<CreateAddressStoreResponse> updateAddressStore(
      @Path("storeCode") String? storeCode,
      @Path() int? idAddressStore,
      @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/store_address/{idAddressStore}")
  Future<DeleteAddressStoreResponse> deleteAddressStore(
      @Path("storeCode") String? storeCode, @Path() int? idAddressStore);

  @GET("store/{storeCode}/shipments")
  Future<AllShipmentResponse> getAllShipmentStore(
      @Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/shipments/{idShipment}")
  Future<AddTokenShipmentResponse> addTokenShipment(
      @Path("storeCode") String? storeCode,
      @Path() int? idShipment,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/message_customers")
  Future<AllChatCustomerResponse> getAllChatUser(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
  );

  @GET("store/{storeCode}/message_customers/{idCustomer}")
  Future<AllMessageResponse> getAllMessageUser(
    @Path("storeCode") String? storeCode,
    @Path() int? idCustomer,
    @Query("page") int numberPage,
  );

  @POST("store/{storeCode}/message_customers/{idCustomer}")
  Future<SendMessageResponse> sendMessageToCustomer(
    @Path("storeCode") String? storeCode,
    @Path() int? idCustomer,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/attribute_fields")
  Future<AttributesResponse> getAllAttributeFields(
    @Path("storeCode") String? storeCode,
  );

  @PUT("store/{storeCode}/attribute_fields")
  Future<AttributesResponse> updateAttributeFields(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/payment_methods")
  Future<PaymentMethodResponse> getPaymentMethod(
    @Path("storeCode") String? storeCode,
  );

  @PUT("store/{storeCode}/payment_methods/{idPaymentMethod}")
  Future<UpdatePaymentResponse> upDatePaymentMethod(
    @Path("storeCode") String? storeCode,
    @Path() int? idPaymentMethod,
    @Body() Map<String, dynamic> body,
  );

  /// order manage

  @GET("store/{storeCode}/orders")
  Future<AllOrderResponse> getAllOrder(
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

  @GET("store/{storeCode}/orders/status_records/{idOrder}")
  Future<StateHistoryOrderResponse> getStateHistoryOrder(
    @Path("storeCode") String? storeCode,
    @Path() int? idOrder,
  );

  @POST("store/{storeCode}/orders/change_order_status")
  Future<ChangeOrderStatusResponse> changeOrderStatus(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/orders/change_payment_status")
  Future<ChangePaySuccessResponse> changePaymentStatus(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/orders/{orderCode}")
  Future<OrderResponse> getOneOrder(
    @Path() String storeCode,
    @Path() String orderCode,
  );

  /// customer manage

  @GET("store/{storeCode}/customers")
  Future<AllCustomerResponse> getAllInfoCustomer(
    @Path() String storeCode,
    @Query("page") int numberPage,
  );

  /// report
  @GET("store/{storeCode}/report/overview")
  Future<ReportResponse> getReport(
    @Path() String storeCode,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
    @Query("date_from_compare") String dateFromCompare,
    @Query("date_to_compare") String dateToCompare,
  );

  @GET("store/{storeCode}/report/top_ten_products")
  Future<ProductReportResponse> getProductReport(
    @Path() String storeCode,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
  );

  /// review manage

  @GET("store/{storeCode}/reviews")
  Future<AllReviewResponse> getReviewManage(
    @Path() String storeCode,
    @Query("filter_by") String filterBy,
    @Query("filter_by_value") String filterByValue,
  );

  @DELETE("store/{storeCode}/reviews/{idReview}")
  Future<ReviewDeleteResponse> deleteReview(
      @Path("storeCode") String? storeCode, @Path() int? idReview);

  @PUT("store/{storeCode}/reviews/{idReview}")
  Future<UpdateReviewResponse> updateReview(
    @Path("storeCode") String? storeCode,
    @Path() int? idReview,
    @Body() Map<String, dynamic> body,
  );
}
