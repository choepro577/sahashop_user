import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/create_my_program.dart';

class MyProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Chương trình của tôi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            true
                ? // check my program
                Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/my_program_help.jpg"),
                        Container(
                          width: Get.width * 0.8,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Cài đặt chương trình khuyến mãi",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Chương trình khuyến mãi sẽ hiển thị trên giao diện sản phẩm của bạn",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Tạo chương trình khuyến mãi",
              onPressed: () {
                Get.to(() => CreateMyProgram());
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
