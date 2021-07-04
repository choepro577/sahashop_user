import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerInfo {
  static final CustomerInfo _singleton = CustomerInfo._internal();

  String? _token;
  String? _currentStoreCode;
  int? _currentIdUser;

  factory CustomerInfo() {
    return _singleton;
  }

  CustomerInfo._internal();

  Future<void> setCurrentStoreCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (code == null) {
      await prefs.remove(CURRENT_STORE_CODE);
    } else {
      await prefs.setString(CURRENT_STORE_CODE, code);
    }
    this._currentStoreCode = code;
  }

  Future<void> setCurrentIdUser(int idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idUser == null) {
      await prefs.remove(CURRENT_USER_ID);
    } else {
      await prefs.setInt(CURRENT_USER_ID, idUser);
    }
    this._currentIdUser = idUser;
  }

  Future<void> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(CUSTOMER_TOKEN);
    } else {
      await prefs.setString(CUSTOMER_TOKEN, token);
    }
    this._token = token;
  }

  String? getToken() {
    return _token;
  }

  String? getCurrentStoreCode() {
    return _currentStoreCode;
  }

  int? getCurrentIdUser() {
    return _currentIdUser;
  }

  Future<bool> hasLogged() async {
    await loadDataUserSaved();
    if (this._token != null)
      return true;
    else
      return false;
  }

  Future<void> loadDataUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenLocal = prefs.getString(CUSTOMER_TOKEN) ?? null;
    this._token = tokenLocal;

    this._currentStoreCode = prefs.getString(CURRENT_STORE_CODE) ?? null;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CUSTOMER_TOKEN);
    prefs.remove(CURRENT_STORE_CODE);
    DataAppCustomerController dataAppCustomerController = Get.find();
    dataAppCustomerController.checkLogin();
    dataAppCustomerController.getInfoCustomer();

    Get.offNamed('customer_home');

    SahaAlert.showSuccess(message: "Đã đăng xuất");
  }


}
