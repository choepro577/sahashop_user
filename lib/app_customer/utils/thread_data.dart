import 'package:sahashop_user/app_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlowData {
  static final FlowData _singleton = FlowData._internal();

  bool _isOnline = false;

  factory FlowData() {
    return _singleton;
  }

  void setIsOnline(bool status) {
    this._isOnline = status;
  }

  bool getStatusData() {
    return _isOnline;
  }

  FlowData._internal();

  isOnline() {
    return _isOnline;
  }
}
