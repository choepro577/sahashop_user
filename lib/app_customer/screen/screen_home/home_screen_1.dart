import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

import '../data_app_controller.dart';

class HomeScreenStyle1 extends StatefulWidget {
  const HomeScreenStyle1({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle1State createState() => _HomeScreenStyle1State();
}

class _HomeScreenStyle1State extends State<HomeScreenStyle1> {
  final ScrollController _scrollController = ScrollController();
  double _opacity = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      setState(() {

        if(_scrollController.offset>100){
          setState(() {
            _opacity=1;
          });
        }else{
          _opacity = _scrollController.offset/100;
        }
      });
    });
  }


  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.blue,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(microseconds: 250),
              height: 100,
              width: double.infinity,
              color: Colors.white.withOpacity(_opacity),
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
              child:  SearchBarType1(),
            )
          ],
        ));
  }
}