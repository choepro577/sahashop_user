import 'package:sahashop_user/data/remote/response-request/auth/login_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
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
}
