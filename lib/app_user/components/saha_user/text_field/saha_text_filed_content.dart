import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';

class SahaTextFiledContent extends StatelessWidget {
  final String? title;
  final String? contentSaved;
  final Function? onChangeContent;

  SahaTextFiledContent(
      {Key? key, this.title, this.contentSaved, this.onChangeContent})
      : super(key: key);

  Html? html;

  @override
  Widget build(BuildContext context) {
    html = Html(
      data: contentSaved ?? " ",
    );

    return Container(
      child: InkWell(
        onTap: () {
          toChangeScreen();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? "Nội dung",
                    style: TextStyle(color: Colors.black54),
                  ),
                  InkWell(
                    onTap: () {
                      toChangeScreen();
                    },
                    child: Text(
                      "Chỉnh sửa",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            html!
          ],
        ),
      ),
    );
  }

  void toChangeScreen() {
    Get.to(EditContentHtml(
      contentSaved: contentSaved,
    ))!
        .then((value) {

      if (onChangeContent != null) onChangeContent!(value);
    });
  }
}

class EditContentHtml extends StatefulWidget {
  final String? contentSaved;

  const EditContentHtml({Key? key, this.contentSaved}) : super(key: key);

  @override
  _EditContentHtmlState createState() => _EditContentHtmlState();
}

class _EditContentHtmlState extends State<EditContentHtml> {
  HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    super.initState();

    configState();
  }

  Future<bool> _onWillPop() async {
    var txt = await controller.getText();

    Get.back(result: txt);
    return true;
  }

  Future<void> configState() async {
    await Future.delayed(Duration(seconds: 1));

    controller.setFullScreen();

    controller.clearFocus();
    controller.setFocus();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Chỉnh sửa nội dung",
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                tooltip: "Save",
                onPressed: () {
                  _onWillPop();
                }
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 8,top: 0,right: 8,bottom: 8),
            child: HtmlEditor(

                controller: controller, //required
                //other options
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "",
                  shouldEnsureVisible:true,
                  adjustHeightForKeyboard: false,
                  autoAdjustHeight: false,
                  initialText: widget.contentSaved!
                ),
                htmlToolbarOptions: HtmlToolbarOptions(

                  defaultToolbarButtons: [
                    FontButtons(
                        superscript: false,
                        strikethrough: false,
                        subscript: false,
                        clearAll: false),
                    ListButtons(),
                    ColorButtons(),
                    ParagraphButtons(),
                    StyleButtons(),
                    FontSettingButtons(),

                    //  InsertButtons(),
                    OtherButtons(),
                  ],

                  customToolbarInsertionIndices: [2, 5],
                  toolbarType: ToolbarType.nativeScrollable,
                  toolbarPosition: ToolbarPosition.belowEditor,

                ))),
      ),
    );
  }
}
