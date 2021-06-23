import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:get/get.dart' as get2;
import 'package:sahashop_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/screen/login/loginScreen.dart';
import 'package:sahashop_user/utils/msg_code.dart';
import 'package:sahashop_user/utils/user_info.dart';

/// Inteceptor which used in Dio to add authentication
/// token, device code before perform any request
///
class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (UserInfo().getToken() != null) {
      options.headers.putIfAbsent("token", () => UserInfo().getToken());
    }
    print('Link: ${options.uri.toString()}');
    print('Header: ${options.headers}');
    printWrapped('Request: ${options.data}');
    if (options.method == 'POST') {
      options.data = new FormData.fromMap(options.data);
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    print('On Error${error.response}');

    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          error.error = 'Đã hủy kết nối';
          break;
        case DioErrorType.connectTimeout:
          error.error = 'Không thể kết nối đến server';
          break;
        case DioErrorType.receiveTimeout:
          error.error = 'Không thể nhận dữ liệu từ server';
          break;
        case DioErrorType.response:
          if (dioError.response?.statusCode == 429) {
            error.error = 'Bạn gửi quá nhiều yêu cầu xin thử lại sau 1 phút';
          }
          error.error =
              '${dioError.response?.data["msg"] != null ? dioError.response?.data["msg"] : "Có lỗi xảy ra"}';
          break;
        case DioErrorType.sendTimeout:
          error.error = 'Không thể gửi dữ liệu đến server';
          break;
        case DioErrorType.other:
          error.error = error.message;
          break;
      }
    }

    return handler.next(error);
  }


  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('------Response: ${response.data}');

    if (response.data["code"] == 401) {
      UserInfo().setToken(null);
      SahaDialogApp.showDialogNotificationOneButton(
          mess: "Hết phiên đăng nhập mời đăng nhập lại",
          barrierDismissible: false,
          onClose: () {
            get2.Get.offAll(() => LoginScreen());
          });
    }

    if (response.data != null && response.data["success"] == false) {
      throw response.data["msg"] ?? "Đã xảy ra lỗi";
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
