import 'dart:convert';
import '../base_service.dart';
import 'model/device_init.dart';

class DeviceService extends BaseServiceOnline {
  Future<DeviceInit> getDevice() async {
    try {
      var response = await dio
          .post("http://a.vipn.net/api/device/init", data: {"device_type": 2});

      if (response.statusCode == 200) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;

        var res = DeviceInit.fromJson(mapData);

        return res;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString() + "error device utils.init");
      throw handleError(e);
    }
  }
}
