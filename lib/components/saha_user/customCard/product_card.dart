import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/model/product.dart';

import '../../../const/constant.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 110,
    this.aspectRetio = 1.02,
    @required this.product,
    @required this.press,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: SahaSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // child:
                  //     CachedNetworkImage(imageUrl: product.images[0].imageUrl),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: SahaPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: true
                            ? SahaPrimaryColor.withOpacity(0.15)
                            : SahaSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/gift_icon.svg",
                        color: true ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
