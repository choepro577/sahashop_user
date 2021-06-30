import 'package:dio/dio.dart';

String handleError(err) {
  if (err is DioError) {
    throw err.error.toString();
  } else {
    throw err.toString();
  }
}
