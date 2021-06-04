import 'package:flutter/material.dart';

class SahaEmptyWidget extends StatelessWidget {
  final String tile;
  final String subtitle;

  const SahaEmptyWidget({Key key, this.tile, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return EmptyListWidget(
    //     image: null,
    //     packageImage: PackageImage.Image_1,
    //     title: tile ?? 'No Thing',
    //     subTitle: subtitle ?? '',
    //     titleTextStyle: Theme.of(context)
    //         .typography
    //         .dense
    //         .display1
    //         .copyWith(color: Color(0xff9da9c7)),
    //     subtitleTextStyle: Theme.of(context)
    //         .typography
    //         .dense
    //         .body2
    //         .copyWith(color: Color(0xffabb8d6)));
  }
}
