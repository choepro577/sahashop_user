import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/utils/money.dart';
import 'package:sahashop_user/model/post.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({
    Key key,
    @required this.post,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final Post post;
  final bool isLoading;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: width,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            DataAppCustomerController dataAppCustomerController = Get.find();
            dataAppCustomerController.toPostAllScreen();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: isLoading
                    ? Container(
                        height: 70,
                        width: 70,
                        color: Colors.black,
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                            )
                          ],
                        ),
                      )
                    : CachedNetworkImage(
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        imageUrl: post.imageUrl == null ? "" : post.imageUrl,
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                        ),
                      ), //post.images[0].imageUrl,
              ),
              SizedBox(width: 5),
              Expanded(
                child: isLoading
                    ? Container(
                        width: 40,
                        height: 10,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Container(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  post.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                SahaDateUtils()
                                    .getDDMMYY(DateTime.parse(post.updatedAt)),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
