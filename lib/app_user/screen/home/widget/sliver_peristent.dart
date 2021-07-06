import 'package:flutter/material.dart';

class Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  Delegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}