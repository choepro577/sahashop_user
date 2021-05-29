import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_user/data/remote/response-request/address/add_token_shipment_response.dart';
import 'package:sahashop_user/data/remote/response-request/address/address_respone.dart';
import 'package:sahashop_user/data/remote/response-request/address/all_address_store_response.dart';
import 'package:sahashop_user/data/remote/response-request/address/all_shipment_response.dart';
import 'package:sahashop_user/data/remote/response-request/address/create_address_store_response.dart';
import 'package:sahashop_user/data/remote/response-request/address/delete_address_store_response.dart';
import 'package:sahashop_user/data/remote/response-request/auth/login_response.dart';
import 'package:sahashop_user/data/remote/response-request/chat/all_chat_customer_reponse.dart';
import 'package:sahashop_user/data/remote/response-request/chat/all_message_response.dart';
import 'package:sahashop_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:sahashop_user/data/remote/response-request/config_ui/app_theme_response.dart';
import 'package:sahashop_user/data/remote/response-request/config_ui/create_app_theme_response.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/combo/create_combo_reponse.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/combo/end_combo_response.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/combo/my_combo_response.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/discount/create_discount_respone.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/discount/end_discount_response.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/voucher/create_voucher_reponse.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/delete_program_response.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/discount/my_program_reponse.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/voucher/end_voucher_response.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/voucher/my_voucher_response.dart';
import 'package:sahashop_user/data/remote/response-request/post/all_post_response.dart';

import 'response-request/auth/register_response.dart';
import 'response-request/category/all_category_response.dart';
import 'response-request/category/create_category_response.dart';
import 'response-request/device_token/device_token_user_response.dart';
import 'response-request/image/upload_image_response.dart';
import 'response-request/post/all_category_post_response.dart';
import 'response-request/post/create_category_post_response.dart';
import 'response-request/post/create_post_response.dart';
import 'response-request/product/all_product_response.dart';
import 'response-request/product/product_response.dart';
import 'response-request/store/all_store_response.dart';
import 'response-request/store/create_store_response.dart';
import 'response-request/store/type_store_respones.dart';

part 'service.g.dart';

@RestApi(baseUrl: "http://103.221.220.124/api/")
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
      @Query("category_ids") String idCategory,
      @Query("descending") bool descending,
      @Query("details") String details,
      @Query("sort_by") String sortBy);

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

  @POST('store/{storeCode}/discounts')
  Future<CreateDiscountResponse> createDiscount(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @POST("device_token_user")
  Future<UpdateDeviceTokenResponse> updateDeviceTokenUser(
      @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/post_categories")
  @FormUrlEncoded()
  Future<CreateCategoryPostResponse> createCategoryPost(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/post_categories")
  Future<AllCategoryPostResponse> getAllCategoryPost(@Path() String storeCode);

  @POST("store/{storeCode}/posts")
  @FormUrlEncoded()
  Future<CreatePostResponse> createPost(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/posts")
  Future<AllPostResponse> getAllPost(@Path() String storeCode);

  @GET("store/{storeCode}/discounts")
  Future<MyProgramResponse> getAllDisCount(@Path() String storeCode);

  @GET("store/{storeCode}/vouchers")
  Future<MyVoucherResponse> getAllVoucher(@Path() String storeCode);

  @GET("store/{storeCode}/combos")
  Future<MyComboResponse> getAllCombo(@Path() String storeCode);

  @PUT("store/{storeCode}/discounts/{idDiscount}")
  Future<MyProgramResponse> updateDiscount(@Path() String storeCode,
      @Path() int idDiscount, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/discounts/{idDiscount}")
  Future<DeleteProgramResponse> deleteDiscount(
      @Path() String storeCode, @Path() int idDiscount);

  @DELETE("store/{storeCode}/vouchers/{idVoucher}")
  Future<DeleteProgramResponse> deleteVoucher(
      @Path() String storeCode, @Path() int idVoucher);

  @DELETE("store/{storeCode}/combos/{idCombo}")
  Future<DeleteProgramResponse> deleteCombo(
      @Path() String storeCode, @Path() int idCombo);

  @POST("store/{storeCode}/vouchers")
  Future<CreateVoucherResponse> createVoucher(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/vouchers/{idVoucher}")
  Future<CreateVoucherResponse> updateVoucher(@Path() String storeCode,
      @Path() int idVoucher, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/vouchers_end")
  Future<EndVoucherResponse> getEndVoucherFromPage(
      @Path() String storeCode, @Query("page") int numberPage);

  @GET("store/{storeCode}/discounts_end")
  Future<EndDiscountResponse> getEndDiscountFromPage(
      @Path() String storeCode, @Query("page") int numberPage);

  @GET("store/{storeCode}/combos_end")
  Future<EndComboResponse> getEndComboFromPage(
      @Path() String storeCode, @Query("page") int numberPage);

  @POST("store/{storeCode}/combos")
  Future<CreateComboResponse> createCombo(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/combos/{idCombo}")
  Future<CreateComboResponse> updateCombo(@Path() String storeCode,
      @Path() int idCombo, @Body() Map<String, dynamic> body);

  @GET("place/vn/province")
  Future<AddressResponse> getProvince();

  @GET("place/vn/district/{idProvince}")
  Future<AddressResponse> getDistrict(@Path() int idProvince);

  @GET("place/vn/wards/{idDistrict}")
  Future<AddressResponse> getWard(@Path() int idDistrict);

  @POST("store/{storeCode}/store_address")
  Future<CreateAddressStoreResponse> createAddressStore(
      @Path() String storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/store_address")
  Future<AllAddressStoreResponse> getAllAddressStore(@Path() String storeCode);

  @PUT("store/{storeCode}/store_address/{idAddressStore}")
  Future<CreateAddressStoreResponse> updateAddressStore(
      @Path() String storeCode,
      @Path() int idAddressStore,
      @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/store_address/{idAddressStore}")
  Future<DeleteAddressStoreResponse> deleteAddressStore(
      @Path() String storeCode, @Path() int idAddressStore);

  @GET("store/{storeCode}/shipments")
  Future<AllShipmentResponse> getAllShipmentStore(@Path() String storeCode);

  @PUT("store/{storeCode}/shipments/{idShipment}")
  Future<AddTokenShipmentResponse> addTokenShipment(@Path() String storeCode,
      @Path() int idShipment, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/message_customers")
  Future<AllChatCustomerResponse> getAllChatUser(
    @Path() String storeCode,
    @Query("page") int numberPage,
  );

  @GET("store/{storeCode}/message_customers/{idCustomer}")
  Future<AllMessageResponse> getAllMessageUser(
    @Path() String storeCode,
    @Path() int idCustomer,
    @Query("page") int numberPage,
  );

  @POST("store/{storeCode}/message_customers/{idCustomer}")
  Future<SendMessageResponse> sendMessageToCustomer(
    @Path() String storeCode,
    @Path() int idCustomer,
    @Body() Map<String, dynamic> body,
  );
}
