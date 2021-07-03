import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/const/sms_otp.dart';

class TextFieldInputOtp extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? numberPhone;
  final bool? autoFocus;

  const TextFieldInputOtp(
      {Key? key, this.textEditingController, this.numberPhone, this.autoFocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.white,
              length: 6,
//obscureText: true,
              controller: textEditingController,
              obscuringCharacter: '*',
// obscuringWidget: Container(
//
// ),
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return "Hãy điền đủ 6 mã số";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                inactiveColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).primaryColor,
                activeFillColor: Colors.white,
                disabledColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedColor: Theme.of(context).primaryColor,
                selectedFillColor: Colors.white,
                fieldWidth: 40,
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              autoFocus: autoFocus!,
//errorAnimationController: errorController,
// controller: signUpController.textEditingControllerOtp,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                print("Completed");
              },

              onChanged: (value) {},
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
//if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Dùng chính xác số điện thoại ',
              style: TextStyle(
                color: Colors.grey,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: '${numberPhone}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text:
                      ' nhận mã hoặc soạn tin nhắn với nội dung $FIRST_CODE_SMS tới số $NUMBER_CODE_SMS để nhận mã (phí 500đ)',
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            sendSms();
          },
          child: Column(
            children: [
              Text(
                "NHẬN MÃ OTP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> sendSms() async {
    try {
      String _result = await sendSMS(
          message: FIRST_CODE_SMS, recipients: ["+" + NUMBER_CODE_SMS]);
    } catch (error) {
      SahaAlert.showError(message: "Có lỗi khi gửi SMS");
    }
  }
}
