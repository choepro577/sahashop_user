// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SahaService implements SahaService {
  _SahaService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://stkvip.net/api/public/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<RegisterResponse> register(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResponse> login(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResponse.fromJson(_result.data);
    return value;
  }

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
  Future<CreateShopResponse> createStore(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateShopResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProductResponse> createProduct(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProductResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllProductResponse> getAllProduct(
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
      r'idCategory': idCategory,
      r'descending': descending,
      r'details': details,
      r'sortBy': sortBy
    };
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
  Future<CreateCategoryResponse> createCategory(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/categories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = CreateCategoryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateAppThemeResponse> createAppTheme(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'app-theme/$storeCode',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateAppThemeResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetAppThemeResponse> getAppTheme(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'app-theme/$storeCode',
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
        'store/$storeCode/categories',
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
  Future<UploadImageResponse> uploadImage(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('images',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UploadImageResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdateDeviceTokenResponse> updateDeviceTokenUser(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'device_token_user',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdateDeviceTokenResponse.fromJson(_result.data);
    return value;
  }
}
