import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TextFieldChoose extends StatelessWidget {
  final List<String>? listChooseText;
  final String? textInput;
  final Function? onChange;

  TextFieldChoose({this.listChooseText, this.onChange, this.textInput}) {
    contentEditingController.text = textInput!;
  }
  TextEditingController contentEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: Get.width - 20,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: (Colors.grey[400])!),
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
          child: TextFormField(
            controller: contentEditingController,
            onChanged: (v) {
              onChange!(v);
            },
            cursorColor: Colors.grey,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: "Hãy chia sẻ những điều bạn thích về sản phẩm này nhé.",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 35,
          width: Get.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listChooseText!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    contentEditingController.text = listChooseText![index];
                    onChange!(contentEditingController.text);
                  },
                  child: Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: (Colors.grey[400])!),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(child: Text(listChooseText![index])),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
