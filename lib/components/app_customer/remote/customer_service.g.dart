// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerService implements CustomerService {
  _CustomerService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://103.221.220.124/api/customer/';
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
  Future<AllCategoryPostResponse> getAllCategoryPost(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/post_categories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllCategoryPostResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllPostResponse> searchPost(
      storeCode, search, idCategory, descending, sortBy) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(search, 'search');
    ArgumentError.checkNotNull(idCategory, 'idCategory');
    ArgumentError.checkNotNull(descending, 'descending');
    ArgumentError.checkNotNull(sortBy, 'sortBy');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'search': search,
      r'category_ids': idCategory,
      r'descending': descending,
      r'sort_by': sortBy
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/posts?=',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllPostResponse.fromJson(_result.data);
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

  @override
  Future<RegisterResponse> registerAccount(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/register',
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
  Future<InfoCustomerResponse> updateAccount(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = InfoCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResponse> loginAccount(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$storeCode/login',
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
  Future<InfoCustomerResponse> getInfoCustomer(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = InfoCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllMessageCustomerResponse> getAllMessageCustomer(
      storeCode, numberPage) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(numberPage, 'numberPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': numberPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/messages',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllMessageCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SendMessageCustomerResponse> sendMessageToUser(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/messages',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SendMessageCustomerResponse.fromJson(_result.data);
    return value;
  }
}
