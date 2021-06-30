import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class Star extends StatelessWidget {
  int? starInput;
  Function? onTap;

  Star({this.starInput, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onTap!(1);
            },
            child: starInput! >= 1
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: 30,
                    width: 30,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              onTap!(2);
            },
            child: starInput! >= 2
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: 30,
                    width: 30,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              onTap!(3);
            },
            child: starInput! >= 3
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: 30,
                    width: 30,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              onTap!(4);
            },
            child: starInput! >= 4
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: 30,
                    width: 30,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              onTap!(5);
            },
            child: starInput! >= 5
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: 30,
                    width: 30,
                    color: Colors.yellow,
                  ),
          ),
        ],
      ),
    );
  }
}
