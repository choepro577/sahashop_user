import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/home_data/home_data_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/badge_user.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

enum ExpiredEnum { OutOfDate, ExpiryDate }

class HomeController extends GetxController {
  HomeController() {
    loadStoreCurrent();
    getHomeData();
  }

  var preIsPortrait = false;
  var isExpansion = false.obs;
  var opacity = 1.0.obs;
  Rx<Store>? storeCurrent = Store().obs;
  var isLoadingStore = false.obs;
  var errMsg = "".obs;
  var checkNoStore = false.obs;
  var isFirstTimeLogin = false.obs;
  var requiredProduct = false.obs;

  var badgeUser = BadgeUser().obs;
  var homeData = HomeDataUser().obs;

  void onHandleAfterChangeStore() {
    getBadge();
  }

  ExpiredEnum checkExpired() {
    if (getDayExpired() > 0) {
      return ExpiredEnum.ExpiryDate;
    } else {
      return ExpiredEnum.OutOfDate;
    }
  }

  DateTime getDateTimeExpired() {
    var dateExpired = SahaDateUtils()
        .getUtcDateTimeFormString(storeCurrent!.value.dateExpried ?? DateTime.now().toUtc().toString());
    return dateExpired;
  }

  int getDayExpired() {
    var now = DateTime.now()..hour;
    now = DateTime(now.year, now.month, now.day);

    var days = Duration.zero;
    if (storeCurrent!.value.dateExpried != null) {
      var dateExpired = SahaDateUtils()
          .getUtcDateTimeFormString(storeCurrent!.value.dateExpried!);
      days = dateExpired.difference(now);
    }
    return days.inDays;
  }

  void getHomeData() async {
    try {
      var data = await RepositoryManager.homeDataRepository.getHomeData();
      homeData(data);
    } catch (err) {}
  }

  void onChangeExpansion(bool value) {
    isExpansion.value = value;
  }

  void changeOpacityText(double va) {
    opacity.value = va;
  }

  void loadStoreCurrent() async {
    isLoadingStore.value = true;
    errMsg.refresh();
    try {
      var list = (await RepositoryManager.storeRepository.getAll())!;

      if (list.length > 0) {
        var indexStoreSelected;
        if (UserInfo().getCurrentStoreCode() != null) {
          indexStoreSelected = list.indexWhere(
              (storeE) => storeE.storeCode == UserInfo().getCurrentStoreCode());
        }

        if (indexStoreSelected != null && indexStoreSelected >= 0) {
        } else {
          indexStoreSelected = 0;
        }

        Store store;
        store = list[indexStoreSelected];

        setNewStoreCurrent(store);
        setUserIdCurrent(store);
        onHandleAfterChangeStore();
      } else {
        checkNoStore.value = true;
        // storeCurrent = null;
        UserInfo().setCurrentStoreCode(null);
      }

      isLoadingStore.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      errMsg.value = err.toString();
      isLoadingStore.value = false;
    }
  }

  Future<void> getBadge() async {
    try {
      var data = await RepositoryManager.badgeRepository.getBadgeUser();
      badgeUser.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void setNewStoreCurrent(Store store) {
    checkNoStore.value = false;
    UserInfo().setCurrentStoreCode(store.storeCode);
    storeCurrent!.value = store;
  }

  void setUserIdCurrent(Store store) {
    UserInfo().setCurrentIdUser(store.userId);
  }
}
