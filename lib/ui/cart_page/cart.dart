import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/provider/cart_provider.dart';
import 'package:kids_life_flutter/ui/cart_page/farm_stay_cart.dart';
import 'package:kids_life_flutter/provider/farm_stay_cart_provider.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

import 'grocery_cart_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: TabBarView(
          controller: _tabController,
          children: const [GroceryTabView(), FarmStayTabView()]),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: Themes.farmStayAppBar,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(17),
                bottomLeft: Radius.circular(17))),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: TabBar(
          onTap: (int index) {
            _selectedTabIndex = index;
          },
          enableFeedback: false,
          controller: _tabController,
          indicatorColor: Theme.of(context).scaffoldBackgroundColor,
          indicatorPadding: EdgeInsets.all(5),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              child: Container(
                color: Colors.transparent,
                child: Text(
                  "Grocery",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            Tab(
              child: Container(
                color: Colors.transparent,
                child: Text(
                  "Farm Stay",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GroceryTabView extends StatelessWidget {
  const GroceryTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryCartProvider = Provider.of<GroceryCartProvider>(context);

    if (groceryCartProvider.groceryItem.isEmpty) {
      return Center(
          child: Image.asset(
        'images/empty_cart_image.png',
        fit: BoxFit.contain,
      ));
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: buildCheckoutBlock(context),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cart Item : ${groceryCartProvider.groceryItem.length}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          deleteCartAlertBox(
                              context,
                              'Are you sure you want to empty your cart?',
                              'Cart will be emptied',
                              groceryCartProvider);
                        },
                        icon: Icon(
                          CustomIcons.trash,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 15,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: groceryCartProvider.groceryItem.length,
                    itemBuilder: (context, index) {
                      var v =
                          groceryCartProvider.groceryItem.keys.toList()[index];
                      int count = groceryCartProvider.groceryItem[v];
                      return GroceryCartTile(
                        itemModel: groceryCartProvider.groceryItem.keys
                            .toList()[index],
                        count: count,
                      );
                    }),
              ),
            ),
          ],
        ),
      );
    }
  }

  Container buildCheckoutBlock(BuildContext context) {
    final groceryCartProvider = Provider.of<GroceryCartProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0),
          ],
          gradient: Themes.farmStayAppBar),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total : Rs.${groceryCartProvider.getTotalAmount()}",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 17
                  )
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text("Checkout",
                  style: Theme.of(context).textTheme.caption
              ),
            ),
          ),
        ],
      )),
    );
  }

  deleteCartAlertBox(
    BuildContext context,
    String title,
    String subtitle,
    GroceryCartProvider groceryCartProvider,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(subtitle),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        groceryCartProvider.clearCart();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              )
            ],
          );
        });
  }
}

class FarmStayTabView extends StatelessWidget {
  const FarmStayTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final farmStayProvider = Provider.of<FarmStayCartProvider>(context);
    final farmStayCart =
        Provider.of<FarmStayCartProvider>(context).farmStayList;
    if (farmStayCart.isEmpty) {
      return Center(
          child: Image.asset(
        'images/empty_cart_image.png',
        fit: BoxFit.contain,
      ));
    } else {
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wishlist Count : ${farmStayCart.length}",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        deleteCartAlertBox(
                            context,
                            'Are you sure you want to empty your cart?',
                            'Cart will be empty',
                            farmStayProvider);
                      },
                      icon: Icon(
                        CustomIcons.trash,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                  constraints: BoxConstraints(
                      maxHeight: double.infinity,
                      minHeight: MediaQuery.of(context).size.height),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: farmStayCart.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FarmStayCart(
                              snapshot: farmStayCart[index],
                              isAddedToCart: true,
                              index: index),
                        );
                      })),
            ),
          ),
        ],
      );
    }
  }

  deleteCartAlertBox(
    BuildContext context,
    String title,
    String subtitle,
    FarmStayCartProvider farmStayProvider,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(subtitle),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        farmStayProvider.emptyCart();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              )
            ],
          );
        });
  }
}
