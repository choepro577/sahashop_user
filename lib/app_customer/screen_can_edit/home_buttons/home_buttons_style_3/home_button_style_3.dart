import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';

import '../list_home_button.dart';

class HomeButtonStyle3Widget extends StatelessWidget {
   HomeButtonStyle3Widget({Key? key, this.homeButton})
      : super(key: key);
   HomeButton? homeButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child:  Container(
          child: Stack(
            children: [
              SizedBox(
                width: 70,
                height: 90,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        child: buildImageButton(
                            imageUrl: homeButton!.imageUrl,
                            typeAction: homeButton!.typeAction),
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: AutoSizeText(
                        homeButton!.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
