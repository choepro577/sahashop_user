import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/profile_user.dart';

class AccountController extends GetxController {
  var user = ProfileUser().obs;

  AccountController() {
    getUser();
  }

  Future<void> getUser() async {
    try {
      var data = await RepositoryManager.profileRepository.getProfile();
      user.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
