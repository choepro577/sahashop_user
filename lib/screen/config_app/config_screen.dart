import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/screen/config_app/config_controller.dart';

import 'ui_data_config.dart';

class ConfigScreen extends StatefulWidget {
  final Widget child;
  const ConfigScreen({Key key, this.child}) : super(key: key);

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  var indexSelected = 0;

  ConfigController configController = Get.find();

  @override
  void initState() {
    super.initState();

    Get.put(ConfigController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Chỉnh sửa giao diện'),
      ),
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      color: Colors.grey[200],
                      child: ListView.builder(
                          itemCount: UIDataConfig.length,
                          itemBuilder: (context, index) {
                            return buildItem(index: index);
                          }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.78,
                        decoration: BoxDecoration(color: Colors.black12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              UIDataConfig[indexSelected].name,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      UIDataConfig[indexSelected].listChildConfig == null ||
                              UIDataConfig[indexSelected]
                                      .listChildConfig
                                      .length ==
                                  0
                          ? Container(
                              height: 5,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: UIDataConfig[indexSelected]
                                  .listChildConfig
                                  .map(
                                    (e) => e.editWidget == null
                                        ? Container()
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.78,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    e.name ?? "",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  e.editWidget
                                                ],
                                              ),
                                            ),
                                          ),
                                  )
                                  .toList(),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SahaButtonFullParent(
                onPressed: () {
                  configController.createAppTheme();
                },
                text: "Lưu cài đặt",
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildItem({int index}) {
    ParentConfig parentConfig = UIDataConfig[index];
    return Container(
      color: indexSelected == index ? Colors.white : Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            indexSelected = index;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                "assets/icons/${parentConfig.icon}",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              parentConfig.name,
              style: TextStyle(
                  fontSize: 14,
                  color: indexSelected == index ? bmColors : Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
