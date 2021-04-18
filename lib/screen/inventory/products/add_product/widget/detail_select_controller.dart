import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/product.dart';

class DetailSelectController extends GetxController {
  var listDetail = RxList<Details>();
  var stringTextSuggestion = "";

  final listSuggestion = [
    "Kích thước",
    "Màu sắc",
    "Kiểu dáng",
    "Tạo thêm phân loại"
  ];

  DetailSelectController() {
    addDetail(listSuggestion[0]);
  }

  void editNameDetail(int indexDetail, String name) {
    if (listDetail[indexDetail] != null) {
      if (listDetail.map((e) => e.name).contains(name)) {
        SahaAlert.showWarning(message: "Phân loại đã có");
        return;
      }
      var newDetail = listDetail[indexDetail];
      newDetail.name = name;

      listDetail[indexDetail] = newDetail;
    }
  }

  void removeDetail(int indexDetail) {
     listDetail.remove(listDetail[indexDetail]);

  }


  void addDetail(String name) {
    if (name == null) {
      var name = getNameNewDetail();

      listDetail.add(Details(name: name, attributes: []));
      return;
    }

    for (var element in listDetail) {
      if (element.name == name) {
        SahaAlert.showError(message: "Thuộc tính này đã thêm từ trước");
        return;
      }
    }

    listDetail.add(Details(name: name, attributes: []));
  }

  void addAttribute(int indexDetail, String name) {
    if (listDetail[indexDetail] != null) {
      if (listDetail[indexDetail]
          .attributes
          .map((e) => e.name)
          .contains(name)) {
        SahaAlert.showWarning(message: "Thuộc tính đã có");
        return;
      }
      listDetail[indexDetail].attributes.add(Attributes(name: name));
    }
  }

  void removeAttribute(int indexDetail, Attributes attributes) {
    listDetail[indexDetail].attributes.remove(attributes);
  }

  void refresh() {
    listDetail.refresh();
  }

  List<String> getListStringBuild(Details details) {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDetail.map((detail) => detail.name).contains(text));

    listNew.insert(0, details.name);
    if (!listNew.contains(listSuggestion.last)) {
      listNew.add(listSuggestion.last);
    }
    return listNew;
  }

  String getNameNewDetail() {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDetail.map((detail) => detail.name).contains(text));

    if (listNew.length == 0) {
      return listSuggestion.last;
    }

    return listNew.first;
  }

  bool checkValidParam() {

    for (var itemDetail in listDetail) {
      var listCompare = listDetail.toList()..remove(itemDetail);

     if( listCompare.map((element) => element.name).toList().contains(itemDetail.name)) {

       SahaAlert.showWarning(message: "Có các phân loại trùng nhau xin kiểm tra lại");
       return false;
     }

    }

    for (var itemDetail in listDetail) {
      if(itemDetail.name == null || itemDetail.name =="") {

        SahaAlert.showWarning(message: "Có các phân loại chưa nhập tên, xin kiểm tra lại");
        return false;
      }

    }
    return true;
  }


  List<Details> getFinalDetail() {
    var listRT =  listDetail.toList()..removeWhere((element) {
      return (element.name == null || element.name == "" ||
          element.attributes == null ||element.attributes.length==0);
    });
    return listRT;
  }
}
