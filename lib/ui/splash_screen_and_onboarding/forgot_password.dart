

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/utils/colors.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';

import 'otp_page.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool phoneIsFocused = false;
  FocusNode _focus = FocusNode();
  bool isPhoneValid = true;
  String phone = "";
  CountryCode code = CountryCode.fromCountryCode('IN');

  void focusPhone(){
    _focus.requestFocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener((){
      print("hello");
      setState(() {
        if(_focus.hasFocus){
          phoneIsFocused = true;
        }
        else{
          phoneIsFocused = false;
        }
      });
    });
  }


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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.08,
                    ),
                    Text(
                      "Forgot Password?",
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
                      child: const Text(
                        "That's ok...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                      child:const Text(
                        "Please enter your registered phone number to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      width: Get.width*0.9-20,
                      child: Stack(
                        children: [
                          Container(
                            height: 45,
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: phoneIsFocused?primary:Colors.grey[300]!, width: 1.0),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 120,
                                  child: CountryCodePicker(
                                    showFlag: true,
                                    padding: EdgeInsets.zero,
                                    alignLeft: true,
                                    initialSelection: 'IN',
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    onChanged: (c){
                                      code = c;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                  child: VerticalDivider(
                                    thickness: 1,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    cursorColor: primary,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                    onChanged: (val){
                                      if(val.length==10){
                                        setState(() {
                                          isPhoneValid = true;
                                        });
                                      }
                                      phone = val;
                                    },
                                    focusNode: _focus,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "XXXXXXXXXX",
                                        contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 30),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: phoneIsFocused?primary:Colors.grey,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !isPhoneValid,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, left: Get.width*0.05+10),
                            child:const  Text(
                              "*Please enter a valid Phone Number",
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
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(phone.length!=10){
                          setState(() {
                            isPhoneValid = false;
                          });
                        }
                        else{
                          Get.to(OTPPage(isSignUp: false, phoneNumber: phone, code: code, func: focusPhone,));
                        }
                      },
                      child: Container(
                        height: 45,
                        width: Get.width*0.9-20,
                        decoration: BoxDecoration(
                            gradient: Themes.detailedBackgroundGradient2,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Center(
                          child: Text(
                            "Continue",
                            style: Theme.of(context).textTheme.caption
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
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