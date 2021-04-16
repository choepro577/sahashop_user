// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
// import 'package:sahashop_user/components/app_customer/screen/data_widget_config.dart';
// import 'package:sahashop_user/screen/config_app/config_controller.dart';
// import 'package:unicorndial/unicorndial.dart';
//
// class CustomerScreen extends StatefulWidget {
//   @override
//   _CustomerScreenState createState() => _CustomerScreenState();
// }
//
// class _CustomerScreenState extends State<CustomerScreen> {
//   ConfigAppController configController = Get.put(ConfigAppController());
//   List<UnicornButton> contactButton = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getAppThemeData();
//   }
//
//   Future<void> getAppThemeData() async {
//     await configController.getAppTheme();
//     setState(() {
//       configController.addButton();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: UnicornDialer(
//           backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
//           parentButtonBackground: Colors.redAccent,
//           orientation: UnicornOrientation.VERTICAL,
//           parentButton: Icon(Icons.phone),
//           childButtons: configController.contactButton ??
//               UnicornButton(
//                   hasLabel: true,
//                   labelText:
//                       configController.ConfigApp.phoneNumberHotline ?? "",
//                   currentButton: FloatingActionButton(
//                     heroTag: "train",
//                     backgroundColor: Colors.redAccent,
//                     mini: true,
//                     child: Icon(Icons.add),
//                     onPressed: () {},
//                   ))),
//       body: Column(
//         children: [
//           LIST_WIDGET_HOME_SCREEN[configController.ConfigApp.homePageType]
//         ],
//       ),
//     );
//   }
// }
