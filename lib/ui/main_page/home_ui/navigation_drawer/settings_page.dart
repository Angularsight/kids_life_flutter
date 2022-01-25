import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';

import 'navigation_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                gradient: Themes.titleBackgroundGradient,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          title: Text(
            "Green Trench",
            style: theme.textTheme.bodyText1,
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 10),
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
          ]),
      drawer: const NavigationDrawer(),
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: ExactAssetImage('images/splash_screen.png'),
              //         fit: BoxFit.cover)),
              child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaY: 15,
                      sigmaX:
                          15), //SigmaX and Y are just for X and Y directions
                  child: Image.asset(
                    'images/splash_screen.png',
                    fit: BoxFit.cover,
                  ) //here you can use any widget you'd like to blur .
                  )),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07,
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: buildProfilePicWidget(theme),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.6,
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "My Account",
                              style: theme.textTheme.caption!.copyWith(
                                  color: Colors.white,
                                  fontSize: 24,
                                  shadows: [
                                    const Shadow(
                                        color: Colors.black,
                                        offset: Offset(1, 2),
                                        blurRadius: 4)
                                  ]),
                            ),
                          ),
                          buildAccountRow(context, 'Email', CustomIcons.email,
                              Colors.orangeAccent),
                          buildAccountRow(context, 'Phone No.',
                              CustomIcons.phone, Colors.blue),
                          buildAccountRow(context, 'Location',
                              CustomIcons.location, Colors.redAccent),
                          buildAccountRow(context, 'Reset Password',
                              CustomIcons.password, Colors.lightGreenAccent),
                          buildAccountRow(context, 'Invite and earn Rs.100',
                              CustomIcons.money, Colors.yellow),
                          buildAccountRow(context, 'Share your inventory',
                              CustomIcons.share, Colors.blueAccent),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfilePicWidget(ThemeData theme) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: theme.accentColor,
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 57,
              child: ClipOval(
                  child: Image.asset(
                'images/splash_screen.png',
                fit: BoxFit.cover,
              ))),
        ),
        Positioned(
          top: 80,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            child: Icon(
              CustomIcons.edit,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }

  Widget buildAccountRow(
      BuildContext context, String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 21,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Icon(
                            icon,
                            color: color,
                            size: 30,
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "$title",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Icon(
                CustomIcons.right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
