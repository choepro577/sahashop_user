import 'package:sahashop_user/const/const_database_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThreadData {
  static final ThreadData _singleton = ThreadData._internal();

  bool _isOnline = true;

  factory ThreadData() {
    return _singleton;
  }

  void setStatusData(bool status) {
    this._isOnline = status;
  }

  bool getStatusData() {
    return _isOnline;
  }

  ThreadData._internal();

  isOnline() {
    return _isOnline;
  }
}
