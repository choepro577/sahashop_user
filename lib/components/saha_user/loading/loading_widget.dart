import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SahaLoadingWidget extends StatelessWidget {
  final double size;


  const SahaLoadingWidget({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SpinKitRipple(
      color: Colors.black,
      size: size ?? 100.0,
    );
  }
}
