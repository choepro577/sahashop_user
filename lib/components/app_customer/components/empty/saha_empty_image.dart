import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyImage extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyImage({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SvgPicture.asset(
        "assets/svg/photo.svg",
        width: width,
        height: height,
        color: Colors.grey,
      ),
    );
  }
}
