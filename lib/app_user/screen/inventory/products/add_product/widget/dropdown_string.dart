import 'package:flutter/material.dart';

class CustomDropDownString extends StatelessWidget {
  final String? value;
  final String? hint;
  final String? errorText;
  final List<DropdownMenuItem<String>>? items;
  final Function? onChanged;

  const CustomDropDownString(
      {Key? key,
      this.value,
      this.hint,
      this.items,
      this.onChanged,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
              color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5,right: 5),
            child: SizedBox(
              height: 35,
              child: DropdownButton<String>(
                value: items!.map((e) => e.value).contains(value)
                    ? value
                    : items!.map((e) => e.value).toList()[0],
                hint: Text(
                  hint!,
                  style: TextStyle(

                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // style:  TextStyle(
                //   color: Colors.green
                // ),
                items: items,
                onChanged: (item) {
                  onChanged!(item);
                },
                isExpanded: true,
                underline: Container(),
                icon: Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
