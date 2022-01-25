

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/navigation_drawer/navigation_drawer.dart';
import 'package:kids_life_flutter/ui/main_page/particular_category/particular_category_list_tile.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';


class ParticularCategory extends StatefulWidget {
  final String? category;
  final ItemModelSuper productsList;
  const ParticularCategory({Key? key, this.category,required this.productsList}) : super(key: key);

  @override
  _ParticularCategoryState createState() => _ParticularCategoryState();
}

class _ParticularCategoryState extends State<ParticularCategory> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(context, theme),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 3,
                child: buildSearchBar()),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.category}",style: theme.textTheme.headline1,),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0,left: 8),
                child: Text("Our Top Picks",style: theme.textTheme.headline6!.copyWith(color: Colors.white.withOpacity(0.5)),),
              ),
            ),
            Flexible(
              flex: 23,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    minHeight: MediaQuery.of(context).size.height
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: widget.productsList.map.length,
                      itemBuilder: (context,index){
                        return  ParticularCategoryListTile(
                          productDetails:widget.productsList.map[index]
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }

  Padding buildSearchBar() {
    return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 15),
          child: Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(2, 4),
                  blurRadius: 4,
                  spreadRadius: 0)
            ]),
            child: TextField(
              showCursor: true,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  fillColor: const Color(0xffE5E5E5),
                  filled: true,
                  prefixIcon: Icon(
                    CustomIcons.search,
                    color: Colors.black.withOpacity(0.33),
                  ),
                  hintText: 'Search anything',
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.37)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          style: BorderStyle.none))),
              onChanged: (String query) {},
            ),
          ),
        );
  }

  AppBar buildAppBar(BuildContext context, ThemeData theme) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          gradient: Themes.farmStayAppBar,
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
              onTap: () {},
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
    );
  }
}
