import 'package:sahashop_user/app_customer/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreInfo {
  static final StoreInfo _singleton = StoreInfo._internal();

  String? _customerStoreCode;

  factory StoreInfo() {
    return _singleton;
  }

  StoreInfo._internal();

  Future<void> setCustomerStoreCode(String? code) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (code == null) {
        await prefs.remove(CUSTOMER_STORE_CODE);
      } else {
        await prefs.setString(CUSTOMER_STORE_CODE, code);
      }
      this._customerStoreCode = code;
    } catch (err) {
      print(err.toString());
    }
  }

  String? getCustomerStoreCode() {
    return _customerStoreCode;
  }
}
