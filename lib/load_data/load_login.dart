import 'package:sahashop_user/utils/user_info.dart';

class LoadLogin {
  static Future<void> load() async {
    await UserInfo().hasLogged();
  }
}