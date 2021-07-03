import 'package:sahashop_user/app_user/data/remote/response-request/auth/check_exists_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/auth/login_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import '../handle_error.dart';

class LoginRepository {
  Future<DataLogin?> login({String? phone, String? pass}) async {
    try {
      var res = await SahaServiceManager().service!.login({
        "phone_number": phone,
        "password": pass,
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> resetPassword(
      {String? phone, String? pass, String? otp}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .resetPassword({"phone_number": phone, "password": pass, "otp": otp});
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<bool?> changePassword({String? newPass, String? oldPass}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .changePassword({"old_password": oldPass, "new_password": newPass});
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<List<ExistsLogin>?> checkExists(
      {String? email, String? phoneNumber}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .checkExists({"email": email, "phone_number": phoneNumber});
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
