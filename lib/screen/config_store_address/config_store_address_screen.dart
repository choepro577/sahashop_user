import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/screen/config_store_address/all_store_address/all_address_store_screen.dart';

class ConfigStoreAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Cai dat van chuyen shop"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => AllAddressStoreScreen());
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dia chi lay hang',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '22/10 khu pho Tan Lap, phuong Dong hoa, Di an, Binh Duong',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'phuong Dong hoa',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Thi xa Di An',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Binh Duong',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {}),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
