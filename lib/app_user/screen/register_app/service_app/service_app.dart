import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceApp extends StatelessWidget {
  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Các dịch vụ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            serviceCard("assets/images/appstore_chplay.png",
                "Up lên CHPlay và AppStore", ["0342362909", "0868917689"]),
            serviceCard("assets/images/contact_design_image.png",
                "Mở khoá thêm các chức năng", ["0342362909", "0868917689"]),
            serviceCard("assets/images/time_manage.png",
                "Gia hạn thêm các chức năng", ["0342362909", "0868917689"]),
            serviceCard("assets/images/contact_app_image.png",
                "Hỗ trợ, và tư vấn dịch vụ 24/7", ["0342362909", "0868917689"]),
          ],
        ),
      ),
    );
  }

  Widget serviceCard(
      String imageAsset, String title, List<String> phoneNumber) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      height: 200,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [
              Theme.of(Get.context!).primaryColor.withOpacity(0.8),
              Theme.of(Get.context!).primaryColor.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9],
            tileMode: TileMode.repeated),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(4, 8), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: Get.width / 2.5, child: Image.asset(imageAsset)),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(Get.context!)
                          .primaryTextTheme
                          .headline6!
                          .color),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: Get.context!,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(
                              phoneNumber.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  makePhoneCall(
                                    'tel:${phoneNumber[index]}',
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          phoneNumber[index],
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(Get.context!).primaryColor)),
                    child: Center(
                      child: Text(
                        "Gọi ngay",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
