import 'package:flutter/material.dart';

class SahaTextFieldSearch extends StatefulWidget {
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Function? onClose;

  const SahaTextFieldSearch({Key? key, this.onSubmitted, this.onChanged, this.onClose})
      : super(key: key);

  @override
  _SahaTextFieldSearchState createState() => _SahaTextFieldSearchState();
}

class _SahaTextFieldSearchState extends State<SahaTextFieldSearch> {

TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(

        autofocus: true,
        onChanged: (va) {

        },
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,

          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              textEditingController.clear();
              widget.onClose!();
            },
          ),
          prefixIcon: Icon(Icons.search_outlined, color: Colors.grey),
          hintText: 'Nhập từ khóa ...',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,

        ),
      ),
    );
  }
}
