import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SahaLoadingFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.cyan.withOpacity(.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitRipple(
                color: Colors.black,
                size: 100.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
