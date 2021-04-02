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
  Future onRequest(RequestOptions options) {
    if (UserInfo().getToken() != null) {
      options.headers.putIfAbsent("token", () => UserInfo().getToken());
    }

    return super.onRequest(options);
  }

  @override
  Future onError(DioError error) {
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          return errorMess('Request to API server was cancelled');
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          return errorMess('Connection timeout with API server');
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          return errorMess('Receive timeout in connection with API server');
          break;
        case DioErrorType.RESPONSE:
          return errorMess(
              'Received invalid status code: ${dioError.response.statusCode}');
          break;
        case DioErrorType.SEND_TIMEOUT:
          return errorMess('Send timeout in connection with API server');
          break;
        case DioErrorType.SEND_TIMEOUT:
          return errorMess('Send timeout in connection with API server');
          break;
        case DioErrorType.DEFAULT:
          return errorMess(error.message);
          break;
      }
    }
    return errorMess("Có lỗi xảy ta");
  }

  errorMess(String mess) async {
    return mess;
  }

  @override
  Future onResponse(Response response) async {
    print('Response: ${response.data}');

    if (response.data["code"] == 401) {
      UserInfo().setToken(null);
      SahaDialogApp.showDialogOneButton(
          mess: "Hết phiên đăng nhập mời đăng nhập lại",
          barrierDismissible: false,
          onClose: () {
            get2.Get.offAll(() => LoginScreen());
          });
    }

    if (response.statusCode != 200 && response.data["success"] == false) {
      return super.onError(DioError(
        request: response.request,
        response: response,
        error: "Đã xảy ra lỗi ERR5000",
      ));
    }
    if (response.data != null && response.data["success"] == false) {
      throw MSGCODE[response.data["msg_code"]] ?? "Đã xảy ra lỗi";
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
      return super.onResponse(null);
    }

    return super.onResponse(response);
  }
}
