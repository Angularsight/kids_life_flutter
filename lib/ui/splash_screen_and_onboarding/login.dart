
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/signup_page.dart';
import 'package:kids_life_flutter/ui/utils/colors.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'forgot_password.dart';



extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

bool emailIsValid = false;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email="", password="";
  bool isEmailValid = true, isPasswordValid = true;

  void changeValue(String val, int ind){
    if(ind==0){
      email = val;
      print(email);
    }
    else{
      password = val;
      print(password);
    }
    if(email.isNotEmpty){
      isEmailValid = true;
      setState(() {

      });
    }
    if(password.isNotEmpty){
      isPasswordValid = true;
      setState(() {

      });
    }
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> _submitForm()async{
    if(isEmailValid && isPasswordValid){
      try{
        await _auth.signInWithEmailAndPassword(email: email.toLowerCase().trim(), password: password.trim());
      }catch(error){
        _showFirebaseSignUpError('FirebaseError occured', '$error');
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
              height: Get.height*0.12,
            ),
            const Text(
              "Welcome to Kids Life,",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
            SizedBox(
              height: 2,
            ),
            const Text(
              "Sign in to continue!",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 18
              ),
            ),
            SizedBox(
              height: Get.height*0.12,
            ),
            CustomTextField(name: "Email ID", hintText: "Ex: james@gmail.com", changeFunc: changeValue, ind: 0, isValid: isEmailValid,),
            SizedBox(
              height: 20,
            ),
            CustomTextField(name: "Password", hintText: "●●●●●●●●", changeFunc: changeValue, ind: 1, isValid: isPasswordValid,),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(ForgotPassword());
                  },
                  child:const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.height*0.08,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Visibility(
                visible: !(isEmailValid && isPasswordValid),
                child: Text(
                  email.isNotEmpty&&password.isNotEmpty?"*Email or Password is not valid":"*Please enter the required credentials",
                  style:const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: ()async{
                  if(email.isNotEmpty && password.isNotEmpty){
                    bool entry = await _submitForm();
                    if(entry){
                      Get.to(const HomeScreen());
                    }
                  }
                  else{
                    if(email.isEmpty){
                      isEmailValid = false;
                    }
                    if(password.isEmpty){
                      isPasswordValid = false;
                    }
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
                  child:  Center(
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.22,
            ),
            Container(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "I'm a new user, ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(SignUpPage(), transition: Transition.leftToRight);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15
                      ),
                    ),
                  )
                ],
              ),
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
  CustomTextField({required this.name,required this.hintText, this.changeFunc,required this.ind,required this.isValid});
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;
  bool isValid = true, seen = true;
  String value="";
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
          if(widget.ind==0){
            print(value);
            isValid = value.isValidEmail();
            emailIsValid = isValid;
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
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: widget.isValid?isValid?isFocused?primary:Colors.grey[300]!:Colors.red:Colors.red, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: primary,
                        obscureText: widget.ind==1&&seen,
                        onChanged: (val){
                          widget.changeFunc(val,widget.ind);
                          value = val;
                          if(widget.ind==0&&!isValid){
                            isValid = val.isValidEmail();
                            emailIsValid = isValid;
                          }
                        },
                        focusNode: _focus,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: widget.hintText,
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14
                            )
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.ind==1,
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
            height: widget.ind==0?5:0,
          ),
          Visibility(
            visible: !isValid,
            child: Text(
              widget.ind==0?"*Please enter a valid email id":"",
              style: const TextStyle(
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

