import 'package:flutter/material.dart';

class TransitionAppBar extends StatelessWidget {
  final Widget ?title;

  const TransitionAppBar({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true, delegate: _TransitionAppBarDelegate(title: title!));
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _titleMarginTween = EdgeInsetsTween(
    begin: EdgeInsets.only(top: 100.0 + 5.0),
    end: EdgeInsets.only(top: 10.0 + 50.0 + 5.0),
  );
  final _titleAlignTween =
  AlignmentTween(begin: Alignment.center, end: Alignment.topCenter);

  final Widget? title;

  _TransitionAppBarDelegate({this.title}) : assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / 200.0;

    final titleMargin = _titleMarginTween.lerp(progress);
    final titleAlign = _titleAlignTween.lerp(progress);
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: progress * 110,
          color: Colors.redAccent,
        ),
        Padding(
          padding: titleMargin,
          child: Align(
            alignment: titleAlign,
            child: title,
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 180.0;

  @override
  double get minExtent => 150.0;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return title != oldDelegate.title;
  }
}