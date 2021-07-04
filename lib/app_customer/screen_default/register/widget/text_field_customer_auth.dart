import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TextFieldCustomerAuth extends StatefulWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Icon? icon;
  final String? label;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final bool? autoFocus;


  const TextFieldCustomerAuth({
    Key? key,
    this.textEditingController,
    this.obscureText = false,
    this.keyboardType ,
    this.icon,
    this.label,
    this.validator,
    this.textCapitalization,
    this.autoFocus = false,

  }) : super(key: key);

  @override
  _TextFieldCustomerAuthState createState() => _TextFieldCustomerAuthState();
}

class _TextFieldCustomerAuthState extends State<TextFieldCustomerAuth> {
  var isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.icon ??
              Icon(
                Icons.lock_outlined,
                color: Colors.grey,
              ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller: widget.textEditingController,
              obscureText:
                  widget.obscureText! == false ? false : isHidePassword,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
              autofocus: widget.autoFocus!,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: widget.label ?? "Mật khẩu",
              ),
              style: TextStyle(fontSize: 15),
              minLines: 1,
              maxLines: 1,
              onChanged: (v) {},
            ),
          ),
          widget.obscureText! == false
              ? Container()
              : Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHidePassword = !isHidePassword;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child:  isHidePassword
                            ? SvgPicture.asset("assets/icons/eyelash.svg")
                            : SvgPicture.asset("assets/icons/visible_eye.svg")),

                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Quên?",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
