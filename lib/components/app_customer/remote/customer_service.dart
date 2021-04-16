import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:sahashop_user/components/app_customer/remote/response/category/all_category_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/category/create_category_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/config_ui/app_theme_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/image/upload_image_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/product/all_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/product/product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/product/query_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/store/all_store_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/store/create_store_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response/store/type_store_respones.dart';

part 'customer_service.g.dart';

@RestApi(baseUrl: "https://stkvip.net/api/public/api/customer/")
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

  @GET("store/{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(@Path() String storeCode);

  @GET("{storeCode}/products")
  Future<QueryProductResponse> getProductWithCategory(
      @Path() String storeCode, int idCategory);
}
