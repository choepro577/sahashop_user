import 'dart:convert';
import 'package:sahashop_user/utils/device_info.dart';
import 'package:dio/dio.dart';
import 'package:sahashop_user/utils/msg_code.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../base_service.dart';
import 'model/product_request.dart';
import 'model/product_response.dart';

class ProductService extends BaseServiceOnline {
  Future<DataProductCreate> create({ProductRequest productRequest}) async {
    try {

      var response = await dio.post("store/1/products", data: productRequest.toJson());

      dio.options.headers['token'] = UserInfo().token;
      
      if (response.statusCode == 201) {
        var mapData = (response.data is String)
            ? jsonDecode(response.data)
            : response.data;
        var res = ProductResponse.fromJson(mapData);
        return res.data;
      } else {
        throw "err 200";
      }
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw "Connection Timeout";
      }
      if (e is DioError) {
        throw MSGCODE["${e.response.data["msg_code"]}"];
      }
    }
  }
}
