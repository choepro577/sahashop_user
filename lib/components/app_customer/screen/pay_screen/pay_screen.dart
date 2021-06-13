import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sahashop_user/utils/user_info.dart';

class PayScreen extends StatelessWidget {
  final String orderCode;
  PayScreen({this.orderCode});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thanh toán"),
      ),
      body: WebviewScaffold(
        url:
            "https:sahashop.net/api/customer/${UserInfo().getCurrentStoreCode()}/purchase/pay/$orderCode",
      ),
    );
  }
}
