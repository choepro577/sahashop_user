import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SahaSimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const SahaSimmer({Key key, this.isLoading, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white60,
            enabled: true,
            child: child)
        : child;
  }
}
