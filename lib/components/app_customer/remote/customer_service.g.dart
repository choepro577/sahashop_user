// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerService implements CustomerService {
  _CustomerService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://sahashop.net/api/public/api/customer/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<AllStoreResponse> getAllStore() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllStoreResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllProductResponse> getAllProduct(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TypeShopResponse> getAllTypeOfStore() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('type_of_store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TypeShopResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetAppThemeResponse> getAppTheme(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/app-theme',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetAppThemeResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllCategoryResponse> getAllCategory(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/categories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllCategoryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<QueryProductResponse> getProductWithCategory(
      storeCode, idCategory) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idCategory, 'idCategory');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = QueryProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<QueryProductResponse> searchProduct(
      storeCode, search, idCategory, descending, details, sortBy) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(search, 'search');
    ArgumentError.checkNotNull(idCategory, 'idCategory');
    ArgumentError.checkNotNull(descending, 'descending');
    ArgumentError.checkNotNull(details, 'details');
    ArgumentError.checkNotNull(sortBy, 'sortBy');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'search': search,
      r'category_ids': idCategory,
      r'descending': descending,
      r'details': details,
      r'sort_by': sortBy
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/products?=',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = QueryProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HomeResponse> getHomeApp(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/home_app',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HomeResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrdersResponse> createOrder(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/orders',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrdersResponse.fromJson(_result.data);
    return value;
  }
}
