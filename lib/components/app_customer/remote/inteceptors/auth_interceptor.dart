import 'package:dio/dio.dart';

import 'package:get/get.dart' as get2;
import 'package:sahashop_user/components/app_customer/screen/login/login_screen.dart';
import 'package:sahashop_user/components/app_customer/utils/customer_info.dart';
import 'package:sahashop_user/utils/msg_code.dart';
class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (CustomerInfo().getToken() != null) {
      options.headers
          .putIfAbsent("customer-token", () => CustomerInfo().getToken());
    }
    print('Header: ${options.headers}');
    print('Request: ${options.data}');
    print('Link: ${options.uri.toString()}');

    if (options.method == 'POST') {
      options.data = new FormData.fromMap(options.data);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    print('Response: ${error.response}');
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          return errorMess('Đã hủy kết nối');

        case DioErrorType.connectTimeout:
          return errorMess('Không thể kết nối đến server');

        case DioErrorType.receiveTimeout:
          return errorMess('Không thể nhận dữ liệu từ server');

        case DioErrorType.response:
          if (dioError.response?.statusCode == 429) {
            return errorMess(
                'Bạn gửi quá nhiều yêu cầu xin thử lại sau 1 phút');
          }

          return errorMess(
              '${dioError.response?.data["msg"] != null ? dioError.response?.data["msg"] : "Có lỗi xảy ra"}');

        case DioErrorType.sendTimeout:
          return errorMess('Không thể gửi dữ liệu đến server');

        case DioErrorType.other:
          return errorMess(error.message);

      }
    }
    return errorMess("Có lỗi xảy ta");
  }

  errorMess(String mess) async {
    return mess;
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('------Response: ${response.data}');

    if (response.data["code"] == 401) {
      get2.Get.to(() => LoginScreenCustomer());
    }

    if (response.data != null && response.data["success"] == false) {
      throw MSGCODE[response.data["msg"]] ?? "Đã xảy ra lỗi";
    }

    if (response.data != null &&
        response.data["code"] != 200 &&
        response.data["code"] != 400 &&
        response.data["code"] != 500) {
      try {
        if (response.data["code"] == 401) {
          print("Logout");
        } else {}
      } catch (e) {
        print(e.toString());
      }
      return super.onResponse(response, handler);
    }

    return super.onResponse(response, handler);
  }
}