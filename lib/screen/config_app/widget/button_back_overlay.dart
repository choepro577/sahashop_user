import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/const/constant.dart';

class ButtonBackOverLay {
  static final ButtonBackOverLay _singleton = ButtonBackOverLay._internal();
  factory ButtonBackOverLay() {
    return _singleton;
  }
  ButtonBackOverLay._internal();
  var entry;

  BuildContext _context;

  void show(BuildContext context) {
    _context = context;

    if(entry == null) {
      entry = _createOverlayEntry(context);
      Overlay.of(context).insert(entry);
    }

  }

  void hide() {
    if (_context != null) {
      entry.remove();
      entry = null;
      _context = null;
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(builder: (context) => DragWidgetOverlay());
  }
}

class DragWidgetOverlay extends StatefulWidget {
  @override
  _DragWidgetOverlayState createState() => _DragWidgetOverlayState();
}

class _DragWidgetOverlayState extends State<DragWidgetOverlay> {
  double x = 20;
  double y = 20;


  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    y = MediaQuery.of(context).padding.top+5;
    x =  MediaQuery.of(context).size.width/3;
  }


  @override
  Widget build(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    var size = MediaQuery.of(context).size;

    return Positioned(
      left: x,
      top: y,
      height: 30,
      child: Draggable(
        onDragEnd: (DraggableDetails details) {
          setState(() {
            x = details.offset.dx;
            y = details.offset.dy;
          });
        },
        feedback: buildButton(),
        child: buildButton(),
        childWhenDragging: Container(),
      ),
    );
  }

  Widget buildButton() {
    return SizedBox(
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            Get.back();

          },
          child: Container(
            decoration: BoxDecoration(
              color: SahaPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey)
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios,size: 13, color: Colors.white),
                Text("Trở về chỉnh sửa", style: TextStyle(
                  color: Colors.white
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
