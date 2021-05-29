// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SahaService implements SahaService {
  _SahaService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://103.221.220.124/api/';
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
      r'category_ids': idCategory,
      r'descending': descending,
      r'details': details,
      r'sort_by': sortBy
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
  Future<CreateDiscountResponse> createDiscount(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/discounts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateDiscountResponse.fromJson(_result.data);
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

  @override
  Future<CreateCategoryPostResponse> createCategoryPost(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/post_categories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = CreateCategoryPostResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllCategoryPostResponse> getAllCategoryPost(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/post_categories',
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
  Future<CreatePostResponse> createPost(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/posts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = CreatePostResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllPostResponse> getAllPost(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/posts',
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
  Future<MyProgramResponse> getAllDisCount(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/discounts',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyProgramResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MyVoucherResponse> getAllVoucher(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/vouchers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyVoucherResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MyComboResponse> getAllCombo(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/combos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyComboResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MyProgramResponse> updateDiscount(storeCode, idDiscount, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idDiscount, 'idDiscount');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/discounts/$idDiscount',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyProgramResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteProgramResponse> deleteDiscount(storeCode, idDiscount) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idDiscount, 'idDiscount');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/discounts/$idDiscount',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteProgramResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteProgramResponse> deleteVoucher(storeCode, idVoucher) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idVoucher, 'idVoucher');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/vouchers/$idVoucher',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteProgramResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteProgramResponse> deleteCombo(storeCode, idCombo) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idCombo, 'idCombo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/combos/$idCombo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteProgramResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateVoucherResponse> createVoucher(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/vouchers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateVoucherResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateVoucherResponse> updateVoucher(
      storeCode, idVoucher, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idVoucher, 'idVoucher');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/vouchers/$idVoucher',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateVoucherResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<EndVoucherResponse> getEndVoucherFromPage(
      storeCode, numberPage) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(numberPage, 'numberPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': numberPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/vouchers_end',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EndVoucherResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<EndDiscountResponse> getEndDiscountFromPage(
      storeCode, numberPage) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(numberPage, 'numberPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': numberPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/discounts_end',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EndDiscountResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<EndComboResponse> getEndComboFromPage(storeCode, numberPage) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(numberPage, 'numberPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': numberPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/combos_end',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EndComboResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateComboResponse> createCombo(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/combos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateComboResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateComboResponse> updateCombo(storeCode, idCombo, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idCombo, 'idCombo');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/combos/$idCombo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateComboResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddressResponse> getProvince() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'place/vn/province',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddressResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddressResponse> getDistrict(idProvince) async {
    ArgumentError.checkNotNull(idProvince, 'idProvince');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'place/vn/district/$idProvince',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddressResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddressResponse> getWard(idDistrict) async {
    ArgumentError.checkNotNull(idDistrict, 'idDistrict');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'place/vn/wards/$idDistrict',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddressResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateAddressStoreResponse> createAddressStore(storeCode, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/store_address',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateAddressStoreResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllAddressStoreResponse> getAllAddressStore(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/store_address',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllAddressStoreResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CreateAddressStoreResponse> updateAddressStore(
      storeCode, idAddressStore, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idAddressStore, 'idAddressStore');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/store_address/$idAddressStore',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CreateAddressStoreResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<DeleteAddressStoreResponse> deleteAddressStore(
      storeCode, idAddressStore) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idAddressStore, 'idAddressStore');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/store_address/$idAddressStore',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeleteAddressStoreResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllShipmentResponse> getAllShipmentStore(storeCode) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/shipments',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllShipmentResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddTokenShipmentResponse> addTokenShipment(
      storeCode, idShipment, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idShipment, 'idShipment');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/shipments/$idShipment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddTokenShipmentResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllChatCustomerResponse> getAllChatUser(storeCode, numberPage) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(numberPage, 'numberPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': numberPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/message_customers',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllChatCustomerResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AllMessageResponse> getAllMessageUser(
      storeCode, idCustomer, numberPage) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idCustomer, 'idCustomer');
    ArgumentError.checkNotNull(numberPage, 'numberPage');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': numberPage};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/message_customers/$idCustomer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AllMessageResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SendMessageResponse> sendMessageToCustomer(
      storeCode, idCustomer, body) async {
    ArgumentError.checkNotNull(storeCode, 'storeCode');
    ArgumentError.checkNotNull(idCustomer, 'idCustomer');
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'store/$storeCode/message_customers/$idCustomer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SendMessageResponse.fromJson(_result.data);
    return value;
  }
}
