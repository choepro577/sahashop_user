import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sahashop_user/const/const_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_service.dart';
import 'model/createShop_respont.dart';
import 'model/listTypeShop_respones.dart';


class CreateShopService extends BaseServiceOnline {
  
  Future<List<DataTypeShop>> getAllShopType() async {
    try {
      var response = await dio.get("type_of_store");
      if (response.statusCode == 200) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;
        if (mapData["success"] == false) {
          throw mapData["msg_code"];
        }
        var res = TypeShopResponse.fromJson(mapData);
        return res.data;
      } else {
        throw "err 200";
      }
    } catch (e) {
      if(e is DioError && e.type == DioErrorType.CONNECT_TIMEOUT){
        throw "Connection Timeout";
      }
      print(e.toString() + "error register");
      throw e.toString();
    }
  }

  Future<DataCreateShop> createShop({String nameShop, String address, String idTypeShop, String code}) async {
    try {
      var form = {
        "name": nameShop,
        "store_code": code,
        "address": address,
        "id_type_of_store": idTypeShop
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();

      dio.options.headers.addAll({
        'token': prefs.getString(USER_TOKEN)
      });

      print("-------------------------------" + prefs.getString(USER_TOKEN));

      var response = await dio.post("store", data: form);
      if (response.statusCode == 201) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;
        if (mapData["success"] == false) {
          throw mapData["msg_code"];
        }
        var res = CreateShopResponse.fromJson(mapData);
        return res.data;
      } else {
        throw "err 201";
      }
    } catch (err) {
      if (err is DioError && err.type == DioErrorType.CONNECT_TIMEOUT) {
        throw "Connection Timeout";
      }

      if (err is DioError) {
        throw err.response.data;

        //MSGCODE["${err.response.data["msg_code"]}"];
      }

      print(err.toString() + "error register");

      return null;
    }
  }



}