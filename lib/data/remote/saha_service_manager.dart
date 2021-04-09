import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sahashop_user/data/remote/service.dart';

import 'inteceptors/auth_interceptor.dart';
import 'service.dart';

/// Class holds reference to Dio clients
class SahaServiceManager {
  /// Singleton
  static final SahaServiceManager _instance = SahaServiceManager._internal();

  factory SahaServiceManager() {
    return _instance;
  }

  SahaServiceManager._internal();

  /// Service getter
  SahaService get service => _service;

  /// Dio client uses to perform normal requests
  Dio dioClient;

  /// Dio client uses to perform upload requests
  Dio uploadClient;
  SahaService _service;


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

    _service = SahaService(
      dioClient,
    );
  }



}
