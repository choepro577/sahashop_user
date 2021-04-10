import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/product.dart';

class DetailSelectController extends GetxController {
  var listDetail = RxList<Details>();

  void addDetail(String name) {
    for(var element in listDetail){
      if(element.name == name) {
        SahaAlert.showError(message: "Thuộc tính này đã thêm từ trước");
        return;
      }
    }

    listDetail.add(Details(
      attributes: [

      ]
    ));

  }


}