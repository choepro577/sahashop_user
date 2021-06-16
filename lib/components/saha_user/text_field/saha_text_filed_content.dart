import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';

class SahaTextFiledContent extends StatelessWidget {
  final String title;
  final String contentSaved;
  final Function onChangeContent;

  SahaTextFiledContent(
      {Key key, this.title, this.contentSaved, this.onChangeContent})
      : super(key: key);

  Html html;

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
            html
          ],
        ),
      ),
    );
  }

  void toChangeScreen() {
    Get.to(EditContentHtml(
      contentSaved: contentSaved,
    )).then((value) {
      if (onChangeContent != null) onChangeContent(value);
    });
  }
}

class EditContentHtml extends StatefulWidget {
  final String contentSaved;

  const EditContentHtml({Key key, this.contentSaved}) : super(key: key);

  @override
  _EditContentHtmlState createState() => _EditContentHtmlState();
}

class _EditContentHtmlState extends State<EditContentHtml> {
  HtmlEditorController controller = HtmlEditorController();

  Widget htmlEditor;

  @override
  void initState() {
    super.initState();

    htmlEditor = HtmlEditor(
        controller: controller, //required
        //other options
        initialText: widget.contentSaved ?? "",
        toolbar: [
          Style(),
          FontSetting(),
          Font(),
          MiscFont(),
          ColorBar(),
          Paragraph()
        ],
        options: HtmlEditorOptions());
  }

  Future<bool> _onWillPop() async {
    var txt = await controller.getText();
    Get.back(result: txt);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          appBar: SahaAppBar(
            titleText: "Chỉnh sửa nội dung",
          ),
          body: htmlEditor),
    );
  }
}
