import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.titleEnd,
    this.pressTitleEnd,
    this.colorTextTitle,
    this.colorTextMore,
  }) : super(key: key);

  final String title;
  final String? titleEnd;
  final Color? colorTextTitle;
  final Color? colorTextMore;

  final GestureTapCallback? pressTitleEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: colorTextTitle ?? Colors.black,
          ),
        ),
        pressTitleEnd == null
            ? Container()
            : GestureDetector(
                onTap: pressTitleEnd,
                child: Text(
                  "${titleEnd == null ? "" : titleEnd}",
                  style: TextStyle(
                    color: colorTextMore ?? Colors.grey[500],
                  ),
                ),
              ),
      ],
    );
  }
}
