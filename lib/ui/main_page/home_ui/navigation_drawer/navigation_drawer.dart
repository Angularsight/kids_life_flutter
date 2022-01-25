import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/navigation_drawer/contact_us_page.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/navigation_drawer/settings_page.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/login.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'Home',
      'All Categories',
      'Offers',
      'Blog',
      'FAQs',
      'Settings',
      'Contact Us',
      'Log Out'
    ];
    List<IconData> icon = [
      CustomIcons.home,
      CustomIcons.allCategories,
      CustomIcons.percentage,
      CustomIcons.blog,
      CustomIcons.faq,
      CustomIcons.settings,
      CustomIcons.phone,
      CustomIcons.logOut
    ];

    return SizedBox(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(gradient: Themes.farmStayAppBar),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: [
                      Container(
                          height: 90,
                          width: 90,
                          decoration:  BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xff02B9AE),
                                  Color(0xff4DA6A0),
                                  Color(0xff12423F)
                                ],
                                begin: AlignmentDirectional.topStart,
                                end: AlignmentDirectional.bottomEnd),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(1,3),
                                spreadRadius: 0,
                                blurRadius: 4
                              )
                            ]
                          ),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white.withOpacity(0.5),
                            size: 40,
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ram Pasumarthi",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 24, shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(1, 2),
                                        blurRadius: 4)
                                  ])),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Owner",
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0,-3),
                            spreadRadius: 0,
                            blurRadius: 4
                        )
                      ]
                    ),
                    child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return DrawerItem(
                              title: title[index], icon: icon[index]);
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  DrawerItem({Key? key, required this.title, required this.icon}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: ()async{
          if(title == 'Contact Us'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUs()));
          }else if(title=='Home'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
          }else if(title=='Settings'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsPage()));
          }else if(title=='Log Out'){
            try{
              signOutAlertBox(context, 'Are you sure you want to sign out?', 'Signing out will put this account on hold');
            }catch(error){
              _showFirebaseSignUpError(context,'Firebase log out error', '$error');
            }
          }
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 24, color: Colors.white,shadows: [ Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1, 3),
                    blurRadius: 4)]))
          ],
        ),
      ),
    );

  }
  Future<void> _showFirebaseSignUpError(BuildContext context,String title,String subtitle) async {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
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
                  child: const Text("Ok",style: TextStyle(
                      color: Colors.grey
                  ),)),
            ],
          )
        ],
      );
    });
  }

  signOutAlertBox(BuildContext context,String title,String subtitle){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.info_outline,color: Colors.red,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: Center(child: Text(title))),
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
                  onPressed: ()async{
                    await _auth.signOut();
                    Navigator.canPop(context)?Navigator.pop(context):null;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                  },
                  child: const Text("Ok",style: TextStyle(
                      color: Colors.grey
                  ),)),
            ],
          )
        ],
      );
    });
  }

}
