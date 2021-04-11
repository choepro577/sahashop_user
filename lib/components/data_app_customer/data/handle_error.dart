import 'package:dio/dio.dart';

String handleErrorCustomer(err) {
  if(err is DioError) {
    throw err.error.toString();
  } else {
    throw err.toString();
  }
}