import 'package:flutter/material.dart';

class SahaAppBar extends PreferredSize {
  final double height;
  final Widget title;
  final Widget leading;
  final List<Widget> actions;

  SahaAppBar({this.leading, this.actions, this.title,  this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.zero,
      child:Divider(
        height: 1,
      ),
    ));
  }
}