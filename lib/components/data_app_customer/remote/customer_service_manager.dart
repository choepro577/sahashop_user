import 'package:dio/dio.dart';
import 'package:sahashop_user/components/data_app_customer/remote/customer_service.dart';
import 'package:sahashop_user/components/data_app_customer/remote/inteceptors/auth_interceptor.dart';
import 'customer_service.dart';

/// Class holds reference to Dio clients
class CustomerServiceManager {
  /// Singleton
  static final CustomerServiceManager _instance =
      CustomerServiceManager._internal();

  factory CustomerServiceManager() {
    return _instance;
  }

  CustomerServiceManager._internal();

  /// Service getter
  CustomerService get service => _service;

  /// Dio client uses to perform normal requests
  Dio dioClient;

  /// Dio client uses to perform upload requests
  Dio uploadClient;
  CustomerService _service;

  /// Initialzation function
  static void initialize() {
    if (_instance.service == null) {
      _instance.getNewInstance();
    }
  }

  /// Return the one and the only instance
  void getNewInstance() {
    final options = BaseOptions(receiveTimeout: 15000);
    dioClient = Dio(options)
      ..interceptors.add(AuthInterceptor())
      ..interceptors;

    uploadClient = Dio(options);

    _service = CustomerService(
      dioClient,
    );
  }
}
