// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerService implements CustomerService {
  _CustomerService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://sahashop.net/api/customer/';
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
  Future<DetailProductResponse> getDetailProduct(storeCode, idProduct) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idProduct, 'idProduct');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/products/$idProduct',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DetailProductResponse.fromJson(_result.data);
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
  Future<OrderResponse> createOrder(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/carts/orders',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderResponse.fromJson(_result.data);
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
  Future<CustomerComboResponse> getComboCustomer(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/combos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomerComboResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<VoucherCustomerResponse> getVoucherCustomer(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/vouchers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = VoucherCustomerResponse.fromJson(_result.data);
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

  @override
  Future<Cart> getItemCart(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$storeCode/carts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Cart.fromJson(_result.data);
    return value;
  }

  @override
  Future<Cart> addVoucherCart(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('$storeCode/carts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Cart.fromJson(_result.data);
    return value;
  }

  @override
  Future<Cart> updateItemCart(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/carts/items',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Cart.fromJson(_result.data);
    return value;
  }

  @override
  Future<Cart> addItemCart(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/carts/items',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Cart.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllIAddressCustomerResponse> getAllAddressCustomer(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/address',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllIAddressCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateUpdateAddressCustomerResponse> createAddressCustomer(
      storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/address',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateUpdateAddressCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateUpdateAddressCustomerResponse> updateAddressCustomer(
      storeCode, idAddressCustomer, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idAddressCustomer, 'idAddressCustomer');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/address/$idAddressCustomer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateUpdateAddressCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteAddressCustomerResponse> deleteAddressCustomer(
      storeCode, idAddressCustomer) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idAddressCustomer, 'idAddressCustomer');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/address/$idAddressCustomer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteAddressCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ShipmentCustomerResponse> chargeShipmentFee(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/shipment/fee',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ShipmentCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<PaymentMethodCustomerResponse> getPaymentMethod(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '$storeCode/payment_methods',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PaymentMethodCustomerResponse.fromJson(_result.data);
    return value;
  }
}
