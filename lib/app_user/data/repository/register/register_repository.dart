import 'package:sahashop_user/app_user/data/remote/response-request/auth/register_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import '../handle_error.dart';

class RegisterRepository {
  Future<DataRegister?> register({String? phone, String? pass, String? name,
    String? otp, String? email}) async {
    try {
      var res = await SahaServiceManager().service!.register({
        "phone_number": phone,
        "password": pass,
        "name":name,
        "otp":otp,
        "email":email
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
