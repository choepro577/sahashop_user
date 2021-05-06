import 'package:flutter/material.dart';

class SahaAppBar extends PreferredSize {
  final double height;
  final Widget titleChild;
  final String titleText;
  final Widget leading;
  final List<Widget> actions;

  SahaAppBar(
      {this.leading,
      this.actions,
      this.titleText,
      this.titleChild,
      this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
            title: titleText != null
                ? Text(
                    titleText,
                    style: TextStyle(color: Colors.black87),
                  )
                : titleChild,
            iconTheme: IconThemeData(
              color: Colors.black87
            ),
            leading: leading,
            actions: actions,
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Divider(
                height: 1,
              ),
            )
    );
  }
}
