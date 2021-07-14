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
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: colorTextTitle ?? Colors.black,
                ),
              ),
              Container(
                height: 2,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.1, 0.9],
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.6),
                      Theme.of(context).primaryColor.withOpacity(0.2)
                    ],
                  ),
                ),
              )
            ],
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
      ),
    );
  }
}
