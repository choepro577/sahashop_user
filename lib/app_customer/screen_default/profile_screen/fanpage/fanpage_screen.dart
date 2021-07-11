import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FanPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("FanPage FaceBook"),
      ),
      body:  InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              "https://www.facebook.com/thietkewebapp"),
        ),
      )
    );
  }
}
