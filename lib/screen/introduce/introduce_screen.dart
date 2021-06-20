import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/screen/login/loginScreen.dart';

import '../../const/constant.dart';

class IntroduceScreen extends StatefulWidget {
  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  int currentPage = 0;
  List<Map<String, String>> pageData = [
    {
      "content": "Design Web App top 1 in the World",
      "splashImage": "assets/images/splash_1.png"
    },
    {
      "content":
      "We help people connect with store \naround United State of America",
      "splashImage": "assets/images/splash_2.png"
    },
    {
      "content": "We show the easy way to shop. \nJust stay at home with us",
      "splashImage": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: pageData.length,
                  itemBuilder: (context, index) => PageViewSplash(
                    content: pageData[index]["content"],
                    splashImage: pageData[index]["splashImage"],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            pageData.length, (index) => buildDot(index)),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.offAll(LoginScreen());
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? bmColors : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageViewSplash extends StatelessWidget {
  final String? content;
  final String? splashImage;

  const PageViewSplash({Key? key, this.content, this.splashImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          "SAHAVI",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: bmColors),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          content!,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey[650]),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Image.asset(splashImage!,
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width),
        ),
      ],
    );
  }
}