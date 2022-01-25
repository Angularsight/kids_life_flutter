

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/terms_and_conditions.dart';
import 'package:kids_life_flutter/ui/utils/colors.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';

import 'login.dart';
import 'otp_page.dart';

String tempPassword = "";
bool conPass = false, verifyEmail = false;

bool validateStructure(String value){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

class SignUpPage extends StatefulWidget {
  final bool isBackOTP;
  SignUpPage({this.isBackOTP = false});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String firstName = "", lastName = "", email = "", password = "", confirmPassword = "", phone = "";
  bool phoneIsFocused = false, isEmailValid = true, isConfirmPasswordValid = true, isAllFilled = true;
  bool isTermsAndConditionsAccepted = false;
  bool isFirstFilled = true, isLastFilled = true, isPhoneFilled = true, isEmailFilled = true, isPasswordFilled = true, isConPassFilled = true;
  CountryCode code = CountryCode.fromCountryCode('IN');
  FocusNode _focus = FocusNode();

  void focusPhone(){
    _focus.requestFocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("back again");
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

  void changeValue(String val, int ind){
    if(ind==0){
      firstName = val;
      isFirstFilled = val.isNotEmpty;
      setState(() {
      });
    }
    else if(ind==1){
      email = val;
      isEmailFilled = val.isNotEmpty;
      setState(() {
      });
    }
    else if(ind==2){
      password = val;
      tempPassword = password;
      isPasswordFilled = val.isNotEmpty;
      setState(() {
      });
    }
    else if(ind == 3){
      confirmPassword = val;
      isConPassFilled = val.isNotEmpty;
      setState(() {
      });
    }
    else if(ind == 4){
      lastName = val;
      isLastFilled = val.isNotEmpty;
      setState(() {
      });
    }
    else if(ind==5){
      phone = val;
      isPhoneFilled = val.isNotEmpty;
      setState(() {
      });
    }

    if(isFirstFilled && isLastFilled && isPhoneFilled && isEmailFilled && isPasswordFilled && isConPassFilled){
      setState(() {
        isAllFilled = true;
      });
    }
  }

  //*************FIREBASE AUTH*********************
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<bool> _submitForm()async{
    if(isFirstFilled && isLastFilled && isPhoneFilled && isEmailFilled && isPasswordFilled && isConPassFilled){
      try{
        //Creating an account via firebase
        await _auth.createUserWithEmailAndPassword(email: email.toLowerCase().trim(), password: password.trim());

        //Storing details in firebase firestore
        final User user = _auth.currentUser!;
        final _userId = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(_userId).set({
          'firstName':firstName,
          'lastName':lastName,
          'countryCode':code.toString(),
          'phoneNo':phone,
          'email':email,
          'password':password,
        });
      }catch(error){
        _showFirebaseSignUpError('Firebase Error', '$error');
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width*0.05),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height*0.075,
            ),
            const Text(
              "Welcome to Kids Life,",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "Sign up to get started!",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 18
              ),
            ),
            SizedBox(
              height: Get.height*0.08,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(name: "First Name", hintText: "Ex: James", changeFunc: changeValue, ind: 0, isValid: isFirstFilled,)
                ),
                Expanded(
                    child: CustomTextField(name: "Last Name", hintText: "Ex: Smith", changeFunc: changeValue, ind: 4, isValid: isLastFilled,)
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: isPhoneFilled?phoneIsFocused?primary:Colors.grey[300]!:Colors.red, width: 1.0),
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
                            inputFormatters: [LengthLimitingTextInputFormatter(10)],
                            keyboardType: TextInputType.phone,
                            onChanged: (val){
                              changeValue(val, 5);
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
                      margin: EdgeInsets.only(left: 20),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 10,
                              color: isPhoneFilled?phoneIsFocused?primary:Colors.grey[300]:Colors.red,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(name: "Email ID", hintText: "Ex: james@gmail.com", changeFunc: changeValue, ind: 1, isValid: isEmailValid&&isEmailFilled),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(name: "Password", hintText: "●●●●●●●●", changeFunc: changeValue, ind: 2, isValid: isPasswordFilled,),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(name: "Confirm Password", hintText: "●●●●●●●●", changeFunc: changeValue, ind: 3, isValid: isConfirmPasswordValid&&isConPassFilled,),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: Get.height*0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isTermsAndConditionsAccepted = !isTermsAndConditionsAccepted;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isTermsAndConditionsAccepted?primary:Colors.white,
                            border: Border.all(color: isTermsAndConditionsAccepted?primary:Colors.grey, width: 2)
                        ),
                      ),
                      isTermsAndConditionsAccepted
                          ? Icon(
                        Icons.check,
                        size: 18.0,
                        color: Colors.white,
                      )
                          : Icon(
                        Icons.check_box_outline_blank,
                        size: 5.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'By creating an account you agree to our',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: ' Terms and Conditions',
                          recognizer: new TapGestureRecognizer()..onTap = (){
                            Get.to(TermsAndConditions());
                          },
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff3e2723),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.01,
            ),
            Visibility(
              visible: !isAllFilled,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "*Please enter all the fields",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: GestureDetector(
                onTap: ()async{
                  isFirstFilled = firstName.isNotEmpty;
                  isLastFilled = lastName.isNotEmpty;
                  isPhoneFilled = phone.isNotEmpty;
                  isEmailFilled = email.isNotEmpty;
                  isPasswordFilled = password.isNotEmpty;
                  isConPassFilled = confirmPassword.isNotEmpty;
                  if(isFirstFilled && isLastFilled && isPhoneFilled && isEmailFilled && isPasswordFilled && isConPassFilled){
                    if(isTermsAndConditionsAccepted){
                      if(conPass && verifyEmail){
                        bool entry = await _submitForm();
                        // ignore: unrelated_type_equality_checks
                        if(entry){
                          Get.to(OTPPage(phoneNumber: phone, code: code, func: focusPhone,));
                        }

                      }
                      else{
                        setState(() {
                          isEmailValid = verifyEmail;
                          isConfirmPasswordValid = conPass;
                        });
                      }
                    }
                    else
                    {
                      Fluttertoast.showToast(
                          msg: 'Please agree to the terms and conditions to continue',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.white,
                          textColor: primary
                      );
                    }
                  }
                  else{
                    isAllFilled = false;
                    setState(() {
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
                      "Sign Up",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "I'm already a user, ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.off(LoginPage(), transition: Transition.rightToLeft);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
  Future<void> _showFirebaseSignUpError(String title,String subtitle) async {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.info_outline,color: Colors.red,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subtitle),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(

                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Ok",style: TextStyle(
                      color: Colors.grey
                  ),)),
            ],
          )
        ],
      );
    });
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
          if(widget.ind==1){
            isValid = value.isValidEmail();
            verifyEmail = isValid;
            print(isValid);
          }
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
      margin: EdgeInsets.symmetric(horizontal: 10),
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
                          if(widget.ind==1&&!isValid){
                            isValid = val.isValidEmail();
                          }
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
              widget.ind==1?"*Please enter a valid email id":widget.ind==3?"*The passwords should match":widget.ind==2?"*Your password does not match the security criteria\n - At least 8 characters.\n - At least 1 uppercase, 1 lowercase, and 1 number.\n - At least 1 special character (ie: @ # ! & \$)":"",
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
