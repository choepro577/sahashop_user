import 'dart:convert';
import 'package:sahashop_user/utils/device_info.dart';
import 'package:dio/dio.dart';
import 'package:sahashop_user/utils/msg_code.dart';
import '../base_service.dart';
import 'model/login_response.dart';
import 'model/logout_response.dart';
import 'model/register_response.dart';

class AuthService extends BaseServiceOnline {

  Future<DataRegister> register({String shopPhone, String pass}) async {
    try {
      var form = {
        "phone_number": shopPhone,
        "password": pass,
      };

      var response = await dio.post("register",data: form);
      print(response);
      print(response.statusCode);
      if (response.statusCode == 201) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;
        if (mapData["success"] == false) {
          throw mapData["msg_code"];
        }

        var res = RegisterResponse.fromJson(mapData);
        return res.data;
      } else {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;
        if (mapData["success"] == false) {
          throw mapData["msg_code"];
        }

        var res = RegisterResponse.fromJson(mapData);
        return res.data;
      }

    } catch (e) {
      if(e is DioError && e.type == DioErrorType.CONNECT_TIMEOUT){
        throw "Connection Timeout";
      }
      if (e is DioError) {
        throw  MSGCODE["${e.response.data["msg_code"]}"];
      }

      return null;
    }
  }

  Future<DataLogin> login({String shopPhone, String pass}) async {
    try {
      var form = {
        "phone_number": shopPhone,
        "password": pass,
      };
      dio.options.headers['DEVICE-CODE'] = DeviceInfo().deviceCode;
      var response = await dio.post("login", data: form);

      if (response.statusCode == 200) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;
        var res = LoginResponse.fromJson(mapData);
        return res.data;
      } else {
        throw "err 200";
      }
    } catch (e) {
      if(e is DioError && e.type == DioErrorType.CONNECT_TIMEOUT){
        throw "Connection Timeout";
      }
      if (e is DioError) {
       throw  MSGCODE["${e.response.data["msg_code"]}"];
      }

      return null;
    }
  }

  Future<bool> logout() async {
    try {
      dio.options.headers['DEVICE-CODE'] = DeviceInfo().deviceCode;
      var response = await dio.get("auth/logout");

      if (response.statusCode == 200) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;

        if (mapData["success"] == false) {
          throw mapData["msg"];
        }

        var res = LogoutResponse.fromJson(mapData);
        return res.success;
      } else {
        throw Exception();
      }
    } catch (e) {

      if(e is DioError && e.type == DioErrorType.CONNECT_TIMEOUT){
         throw "Connection Timeout";
       }
      print(e.toString() + "error logout");
      throw handleError(e);
    }
  }
}
