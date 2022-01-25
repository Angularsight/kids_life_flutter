

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_life_flutter/ui/utils/colors.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 30,
          leading: Container(),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.close,
                  color: white,
                ),
              ),
            )
          ],
          backgroundColor: primary,
          title: Text('Terms and Conditions', style: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 23),),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: MediaQuery.of(context).size.height*0.05),
              child:const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pharetra turpis id est accumsan, vitae mollis dui euismod. Ut vel dolor risus. Phasellus sollicitudin eros rutrum est vestibulum, vitae facilisis nibh gravida. Phasellus a ipsum tincidunt, egestas dui id, ornare mi. Praesent tempus lacus eu odio mattis lacinia. Quisque malesuada tempus ipsum, at posuere libero dignissim nec. Sed consequat sed sapien finibus placerat.\n\nIn consequat tincidunt lorem ultrices viverra. Proin egestas nibh eu neque auctor, id suscipit lorem placerat. Fusce dictum hendrerit neque eu scelerisque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis viverra hendrerit urna, nec pharetra elit tristique quis. Nulla vehicula augue at egestas dignissim. Donec id purus id enim aliquet tristique. Nullam lobortis semper ligula at efficitur. Duis malesuada mauris sed mi molestie, eu hendrerit enim tincidunt. Proin vestibulum sapien in nisi varius convallis id nec diam. Nullam non neque nec nisi tempor consequat sed id nisl. Ut dignissim erat scelerisque, lobortis sapien ut, blandit turpis. Aliquam erat volutpat. Quisque ornare leo vitae neque tincidunt, vitae vehicula quam venenatis. Sed vitae justo eget metus placerat commodo. In fermentum nibh vitae lacus hendrerit imperdiet.\n\nCurabitur nec sem quis elit dictum cursus. Ut malesuada porttitor nunc. Curabitur molestie dui sit amet ante blandit laoreet. Aenean sit amet nibh rutrum, volutpat libero quis, accumsan orci. Proin mattis fringilla libero, at blandit mauris. Integer sed volutpat libero. Aenean sollicitudin nec quam in hendrerit. Aliquam ac leo ante. Duis vehicula feugiat nisl, a condimentum sem egestas non. Integer id elementum justo. Mauris non nisl in massa vestibulum feugiat. Nulla vulputate lacinia condimentum.\n\nPellentesque sollicitudin purus leo, sit amet malesuada magna hendrerit ut. Donec viverra mi quis sollicitudin ultricies. Integer vehicula dolor et tortor vestibulum, ac facilisis lorem accumsan. Vestibulum condimentum, libero vel semper varius, lacus nisi ullamcorper tortor, vitae ornare elit nisi in magna. Vestibulum accumsan dignissim erat, id fermentum nulla mattis ut. Maecenas finibus maximus feugiat. Nam dapibus urna egestas varius porttitor. Aenean imperdiet massa sit amet porta auctor. In hac habitasse platea dictumst. In non sollicitudin nunc, vel consectetur lacus. Donec placerat tristique nunc ac scelerisque. Praesent viverra pharetra leo ut consectetur. Pellentesque quam magna, egestas ut velit quis, sodales efficitur ipsum. Praesent non nibh odio. Duis vehicula iaculis volutpat. ",
                style: TextStyle(fontSize: 16,),
              ),
            ),
          ],
        )
    );
  }
}
