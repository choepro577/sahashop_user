import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'exception.dart';

class BaseServiceOnline {

  Dio dio;

  static const BASE_PATH = "https://sahavi.vn/api/public/api/";

  BaseServiceOnline() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_PATH,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.json,
      headers: {'App-Build-Version': 'mobile'},
    ));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Exception handleError(Exception error) {
    print("zzzzz");
    var errorDescription = 'null';
    var statusCode = -1;
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioErrorType.DEFAULT:
          errorDescription = 'Mất kết nối';
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioErrorType.RESPONSE:
          errorDescription = 'Received invalid status code: ${dioError.response.data}';
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = 'Send timeout in connection with API server';
          break;
      }
      statusCode = (dioError.response != null) ? dioError.response.statusCode : -1;
    } else if (error is CustomException) {
      statusCode = error.statusCode;
      if (error.message == 'success') {
        errorDescription = 'Thành công';
      } else {
        errorDescription = error.message;
      }
    } else {
      errorDescription = 'Unexpected error occured';
    }
    return CustomException(statusCode: statusCode, message: errorDescription);
  }

  bool responseSuccess(var response) {
    return (response.data['status'] == 1 || response.data['status'] == "success") && response.data['error_code'] == 0;
  }
}