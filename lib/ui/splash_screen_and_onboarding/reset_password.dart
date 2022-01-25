

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/signup_page.dart';
import 'package:kids_life_flutter/ui/utils/colors.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';

String tempPassword = "";
bool conPass = false, verifyEmail = false;

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String password="", confirmPassword="";
  bool isPasswordFilled=true, isConPassFilled=true, isConfirmPasswordValid = true, isAllFilled = true;

  void changeValue(String val, int ind){
    if(ind==2){
      password = val;
      tempPassword = password;
      isPasswordFilled = val.isNotEmpty;
      setState(() {
      });
    }
    else{
      confirmPassword = val;
      isConPassFilled = val.isNotEmpty;
      setState(() {
      });
    }

    if(isPasswordFilled && isConPassFilled){
      setState(() {
        isAllFilled = true;
      });
    }
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
//                    Text(
//                      appName,
//                      style: loginHeaderStyle,
//                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.08,
                    ),
                    Text(
                      "New Credentials",
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
                        "Your identity has been verified!\nSet your new password",
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
                    CustomTextField(name: "Password", hintText: "●●●●●●●●", changeFunc: changeValue, ind: 2, isValid: isPasswordFilled,),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(name: "Confirm Password", hintText: "●●●●●●●●", changeFunc: changeValue, ind: 3, isValid: isConfirmPasswordValid&&isConPassFilled,),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.04,
                    ),
                    Visibility(
                      visible: !isAllFilled,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: Get.width*0.05+10),
                            child: Text(
                              "*Please enter all the fields to continue",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: (){
                        isPasswordFilled = password.isNotEmpty;
                        isConPassFilled = confirmPassword.isNotEmpty;
                        if(isPasswordFilled && isConPassFilled){
                          if(conPass){
                            Get.to(const HomeScreen());
                          }
                          else{
                            setState(() {
                              isConfirmPasswordValid = conPass;
                            });
                          }
                        }
                        else{
                          isAllFilled = false;
                        }
                        setState(() {

                        });
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
                            "Update",
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



class CustomTextField extends StatefulWidget {
  final String name, hintText;
  final int ind;
  final changeFunc;
  final bool isValid;
  CustomTextField({required this.name,required this.hintText, this.changeFunc,required this.ind, this.isValid = true});
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false, seen = true, isValid = true;
  String value = "";
  FocusNode _focus = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener((){
      setState(() {
        if(_focus.hasFocus){
          isFocused = true;
        }
        else{
          if(widget.ind==2){
            if(value.length>=8){
              isValid = validateStructure(value);
            }
            else{
              isValid = false;
            }
          }
          isFocused = false;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width*0.05+10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 45,
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: widget.isValid?isValid?isFocused?primary:Colors.grey[300]!:Colors.red:Colors.red, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: primary,
                        obscureText: (widget.ind==2||widget.ind==3)&&seen,
                        onChanged: (val){
                          widget.changeFunc(val,widget.ind);
                          value = val;
                          if(widget.ind==3){
                            if(!isValid){
                              if(value == tempPassword){
                                setState(() {
                                  isValid = true;
                                });
                              }
                            }
                            isValid = tempPassword == value;
                            conPass = isValid;
                          }
                          if(widget.ind==2 && !isValid){
                            print(val);
                            if(val.length>=8){
                              isValid = validateStructure(val);
                            }
                            else{
                              isValid = false;
                            }
                          }
                          setState(() {

                          });
                        },
                        focusNode: _focus,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14
                            )
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.ind==2||widget.ind==3,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            seen = !seen;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            seen?FontAwesomeIcons.eye:FontAwesomeIcons.eyeSlash,
                            color: Colors.grey,
                            size: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 10,
                          color: widget.isValid?isValid?isFocused?primary:Colors.grey[300]:Colors.red:Colors.red,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: widget.ind==1||widget.ind==3||widget.ind==2?5:0,
          ),
          Visibility(
            visible: !isValid,
            child: Text(
              widget.ind==3?"*The passwords should match":widget.ind==2?"*Your password does not match the security criteria\n - At least 8 characters.\n - At least 1 uppercase, 1 lowercase, and 1 number.\n - At least 1 special character (ie: @ # ! & \$)":"",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      ),
    );
  }
}
