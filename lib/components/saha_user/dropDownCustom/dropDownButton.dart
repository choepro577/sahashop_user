import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownButtonCustom extends StatelessWidget {
  String value;
  List<String> item;
  String title;
  Function onChange;

  DropDownButtonCustom({this.value, this.item, this.title, this.onChange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      focusColor: Colors.white,
      value: value,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: item.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 30,
                width: 30,
                child: Text(
                  "Aa",
                  style: TextStyle(fontSize: double.parse(value), color: Colors.black,),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      }).toList(),
      hint: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: onChange,
    );
  }
}
