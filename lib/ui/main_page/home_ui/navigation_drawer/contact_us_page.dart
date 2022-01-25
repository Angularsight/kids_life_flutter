

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/navigation_drawer/navigation_drawer.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }
    else{
      print("could not launch the command");
    }
  }

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const primary = Colors.white;
    const white = Colors.white;
    final textColor = Colors.yellow;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                gradient: Themes.titleBackgroundGradient,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
            ),
          ),
          title: Text("Green Trench",style: theme.textTheme.bodyText1,),
          centerTitle: true,

          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0,top: 10),
                child: IconButton(
                  icon: Icon(
                    CustomIcons.hamburger,
                    size: 30,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    return Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20),
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.notifications_none,
                  size: 30,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {},
                child: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ]
      ),
      drawer: const NavigationDrawer(),


      body: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width*0.08),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height*0.05,
            ),
            Center(
              child: Text(
                "Got an Issue?",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.01,
            ),
            const Center(
              child: Text(
                "We are happy to help!",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primary
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.05,
            ),
            Center(
              child: Text(
                "Call Us",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                customLaunch("tel: +91 9972966699");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.phoneAlt,
                    size: 20,
                    color: primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "+91 9972966699",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primary
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Center(
              child: Text(
                "Email Us",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                customLaunch("mailto:support@cabalo.com?subject=User%20Query%20Cabalo%20Labs&body=I%20have%20a%20query%20about");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.solidEnvelope,
                    size: 20,
                    color: primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "support@cabalo.com",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primary
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height*0.05,
            ),
             SizedBox(
              height: 5,
              child: Divider(
                thickness: 2,
                color: Colors.grey.shade50,
              ),
            ),
            SizedBox(
              height: Get.height*0.05,
            ),
            const Center(
              child: Text(
                "Send us a message",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primary
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.02,
            ),
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: Offset(0,2),
                      blurRadius: 10.0,
                      spreadRadius: 0.5
                  ),
                  // BoxShadow(
                  //     color: Colors.black.withOpacity(0.5),
                  //     offset: Offset(-3.0,-3.0),
                  //     blurRadius: 10.0,
                  //     spreadRadius: 1.0
                  // ),
                ],
              ),
              child: TextField(

                cursorColor: primary,
                controller: _messageController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(400)
                ],
                maxLines: 4,
                onChanged: (val){
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Write a message here\n(Max 400 characters)",
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.02,
            ),
            GestureDetector(
              onTap: (){
                _messageController.clear();
                Fluttertoast.showToast(
                    msg: 'Message Sent Successfully!',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: primary
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: Get.width*0.2),
                padding: EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  gradient: Themes.detailedBackgroundGradient2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send",
                      style: Theme.of(context).textTheme.caption
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
