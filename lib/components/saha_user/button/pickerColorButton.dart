import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PickerColorButton extends StatelessWidget {
 final Color currentColor;
 final Function onChange;

 const PickerColorButton({
   Key key,
   this.currentColor, this.onChange,
 }) : super(key: key);

  //PickerColorButton({this.currentColor, this.onChange});

  // changeColor(Color color) => setState(() => currentColor = color);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 3.0,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: onChange,
                  colorPickerWidth: 300.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: true,
                  displayThumbColor: true,
                  showLabel: true,
                  paletteType: PaletteType.hsv,
                  pickerAreaBorderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(2.0),
                    topRight: const Radius.circular(2.0),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Text('Chọn màu'),
      color: currentColor,
      textColor: useWhiteForeground(currentColor)
          ? const Color(0xffffffff)
          : const Color(0xff000000),
    );
  }
}