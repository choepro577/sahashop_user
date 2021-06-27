import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SahaLoadingContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? gloss;
  final double? borderRadius;

  const SahaLoadingContainer(
      {Key? key, this.height, this.width, this.gloss = 1, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[600]!.withOpacity(gloss!),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 3))),
      ),
    );
  }
}
