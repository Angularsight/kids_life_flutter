


import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      Get.to(()=> const LoginPage(),duration: const Duration(seconds: 2),transition: Transition.fade);
    });
  }
  @override
  Widget build(BuildContext context) {
    final titleGradient = LinearGradient(colors: [Colors.black.withOpacity(0.8),Colors.grey,Colors.blue],);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.75,
            child:Column(
              children: [
                const Image(
                  image: AssetImage("images/splash_screen.png"),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: ShaderMask(shaderCallback: (Rect bounds) {
                    return titleGradient.createShader(bounds);
                  },
                  child: Text("Kids Life",style: GoogleFonts.pacifico(fontWeight: FontWeight.normal,fontSize: 36,color: Colors.black,letterSpacing: 5),)),
                ),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration:const BoxDecoration(
                    color: Colors.black
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}