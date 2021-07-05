import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/const/constant.dart';

class SahaBoxButton extends StatelessWidget {
  const SahaBoxButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    this.numOfitem,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;
  final int? numOfitem;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: SvgPicture.asset(
                      icon!,
                      color: SahaColorUtils().colorTextWithPrimaryColor(),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),

                ],
              ),
            ),
            if (numOfitem != null && numOfitem != 0)
              Positioned(
                top: -1,
                right: 5,
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "$numOfitem",
                      style: TextStyle(
                        fontSize: 10,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
