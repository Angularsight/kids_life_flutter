

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/reset_password.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:kids_life_flutter/ui/utils/colors.dart';

class OTPPage extends StatefulWidget {
  final bool isSignUp;
  final String phoneNumber;
  final func;
  final CountryCode code;
  OTPPage({this.isSignUp = true,required this.phoneNumber,required this.code, this.func});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String enteredOTP = '123456', otpText = "123456";
  bool isOTPValid = true;
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.15,
                    ),
//                    Text(
//                      appName,
//                      style: loginHeaderStyle,
//                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.08,
                    ),
                    Text(
                      "OTP Verification",
                      style: TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                      child: Text(
                        "We just sent you a 6 digit verification code at ${widget.code.dialCode} ${widget.phoneNumber}. Please enter below",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: PinCodeTextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        controller: _otpController,
                        appContext: context,
                        length: 6,
                        textStyle:const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                        ),
                        obscureText: false,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        animationType: AnimationType.fade,
                        boxShadows: [
                          BoxShadow(
                              color: greyShade,
                              offset: Offset(3.0,3.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0
                          ),
                          BoxShadow(
                              color: white,
                              offset: Offset(-3.0,-3.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0
                          ),
                        ],
                        pinTheme: PinTheme(
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          shape: PinCodeFieldShape.box,
                          borderWidth: 0.2,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          fieldWidth: 45,
                          fieldHeight: 45,
                          activeFillColor: Colors.white,
                          activeColor: Colors.grey,
                          selectedColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          //selectedFillColor: Colors.transparent
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        // backgroundColor: Colors.white,
                        enableActiveFill: true,
                        onCompleted: (value) {
                          if(value == otpText){
                            setState(() {
                              isOTPValid = true;
                            });
                          }
                        },
                        onChanged: (value) {
                          enteredOTP = value;
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isOTPValid,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, left: Get.width*0.1),
                            child:const Text(
                              "*Please enter a valid OTP",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.04,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(enteredOTP==otpText){
                          if(widget.isSignUp){
                            Get.to(const HomeScreen());
                          }
                          else{
                            Get.to(ResetPassword());
                          }
                        }
                        else{
                          setState(() {
                            isOTPValid = false;
                            _otpController.clear();
                          });
                        }
                      },
                      child: Container(
                        height: 45,
                        width: Get.width*0.9-20,
                        decoration: BoxDecoration(
                            gradient: Themes.detailedBackgroundGradient2,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            "Verify",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              widget.func();
                              Get.back();
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.keyboard_arrow_left,
                                  size: 18,
                                ),
                                Text(
                                  "Change mobile number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    color: primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            width: 5,
                            child: VerticalDivider(
                              width: 2,
                              thickness: 2,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Fluttertoast.showToast(
                                  msg: 'Code Resent Successfully!',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: primary
                              );
                            },
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                color: primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
