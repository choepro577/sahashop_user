import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';

class ConfigPaymentCustomerController extends GetxController {
  var listNamePaymentMethod = RxList<String?>();
  var listUsePaymentMethod = RxList<bool?>();
  var listIdPaymentMethod = RxList<int>();
  Map<String, dynamic>? listConfig = Map<String, dynamic>();
  var listTextEditingController = RxList<List<TextEditingController>>();
  var listChoosePaymentMethod = RxList<bool>();
  String? namePaymentCurrent = "";
  int? idPaymentCurrentCallBack = 0;

  final int? idPaymentCurrent;

  ConfigPaymentCustomerController({this.idPaymentCurrent}) {
    getPaymentMethod();
  }

  Future<void> getPaymentMethod() async {
    try {
      var res =
          await CustomerRepositoryManager.paymentRepository.getPaymentMethod();
      res!.data!.forEach((element) {
        listNamePaymentMethod.add(element["name"]);
        listUsePaymentMethod.add(element["use"]);
        listIdPaymentMethod.add(element["id"]);
        listConfig = element["config"];
      });

      listNamePaymentMethod.forEach((element) {
        listChoosePaymentMethod.add(false);
      });

      var index = listIdPaymentMethod
          .indexWhere((element) => element == idPaymentCurrent);
      if (index != -1) {
        listChoosePaymentMethod[index] = true;
        namePaymentCurrent = listNamePaymentMethod[index];
        idPaymentCurrentCallBack = listIdPaymentMethod[index];
      }

      // listConfig.forEach((e) {
      //   var listItemInput = Map<String, dynamic>();
      //   var listEditingController = RxList<TextEditingController>();
      //   e.forEach((item) {
      //     listItemInput[item] = "nothing";
      //   });
      //   listItemInput.forEach((key, value) {
      //     listEditingController.add(new TextEditingController());
      //   });
      //   listEditingController.add(new TextEditingController());
      //   listTextEditingController.add(listEditingController);
      // });
    } catch (err) {
      print(err);
      SahaAlert.showError(message: err.toString());
    }
  }

  void checkChooseVoucher(bool value, int index) {
    listChoosePaymentMethod([]);
    listNamePaymentMethod.forEach((element) {
      listChoosePaymentMethod.add(false);
    });

    if (value == false) {
      listChoosePaymentMethod[index] = true;
      namePaymentCurrent = listNamePaymentMethod[index];
      idPaymentCurrentCallBack = listIdPaymentMethod[index];
    }
  }

  void resetData() {
    listNamePaymentMethod([]);
    listUsePaymentMethod([]);
    listIdPaymentMethod([]);
    listTextEditingController([]);
    getPaymentMethod();
  }
}
