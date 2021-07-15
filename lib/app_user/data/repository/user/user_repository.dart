import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/profile/profile_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';

class ProfileRepository {
  Future<ProfileResponse?> getProfile() async {
    try {
      var res = await SahaServiceManager().service!.getProfile();
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<ProfileResponse?> updateProfile(String? name, DateTime? dateOfBirth,
      String? avatarImage, int? sex) async {
    try {
      var res = await SahaServiceManager().service!.updateProfile({
        "name": name,
        "date_of_birth": dateOfBirth!.toIso8601String(),
        "avatar_image": avatarImage,
        "sex": sex,
      });
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
