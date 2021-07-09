import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/model/home_button_config.dart';

import 'home_button_screen.dart';

class ButtonHomeConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Get.to(ButtonHomeConfigScreen());
            },
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/svg/change.svg",
                    width: 15,
                    height: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Tùy chỉnh"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ButtonEditWidget extends StatelessWidget {
  const ButtonEditWidget(
      {Key? key,
      this.homeButton,
      this.onTap,
      this.isShow = false,
      this.added = false,
      this.onRemove,
      this.onAdd})
      : super(key: key);

  final HomeButtonCf? homeButton;
  final Function? onTap;
  final Function? onRemove;
  final Function? onAdd;

  final bool? added;
  final bool? isShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) onTap!();
        },
        child: SizedBox(
          width: 55,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: homeButton!.imageUrl ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SahaLoadingContainer(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    homeButton!.title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    maxLines: 3,
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 2,
                child: isShow!
                    ? InkWell(
                        onTap: () {
                          if (onRemove != null) onRemove!();
                        },
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.clear,
                            size: 9,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (onAdd != null) onAdd!();
                        },
                        child: (added! == true
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.lightGreen,
                                child: Icon(
                                  Icons.check,
                                  size: 9,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.lightBlue,
                                child: Icon(
                                  Icons.add,
                                  size: 9,
                                  color: Colors.white,
                                ),
                              )),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
