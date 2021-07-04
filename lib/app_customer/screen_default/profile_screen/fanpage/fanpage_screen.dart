import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FanPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("FanPage FaceBook"),
      ),
      body: WebviewScaffold(
        url: "https://www.facebook.com/thietkewebapp",
      ),
    );
  }
}
