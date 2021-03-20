import 'package:sahashop_user/data/remote/remote_manager.dart';
import 'package:sahashop_user/utils/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';



class InitDevice {
  static void newCode() async {
    try {
      var device = await RemoteManager.deviceService.getDevice();
      DeviceInfo().deviceCode = device.data.deviceCode;

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('time_save_device', timestamp);
      saveDevice(device.data.deviceCode);
      print("ok get device " + DeviceInfo().deviceCode);
    } catch (err) {
      print('err get device');
    }
  }

  static void handleGetDevice() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int timestamp = prefs.getInt('time_save_device');
      if (timestamp == null || timestamp == 0) {
        newCode();
      } else {
        DateTime before = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateTime now = DateTime.now();

        if (now.isAfter(before.add(Duration(minutes: 5)))) {
          newCode();
        } else {
          String code = prefs.getString('deviceCode');
          if (code == null) {
            newCode();
          } else {

            print("get device local " + code);
            DeviceInfo().deviceCode = code;
          }
        }
      }
    } catch (err) {
      print(err);
    }
  }

  static saveDevice(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("deviceCode", code);
  }

  static logout()async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("deviceCode", null);
    prefs.setInt("time_save_device", null);
  }
}
