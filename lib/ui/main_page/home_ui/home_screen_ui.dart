import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/ui/cart_page/cart.dart';
import 'package:kids_life_flutter/ui/farm_stay/farm_stay_home.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/navigation_drawer/navigation_drawer.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/offers_card.dart';
import 'package:kids_life_flutter/ui/main_page/particular_category/particular_category.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';

import 'categories_card.dart';

class HomeScreenUi extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> wantedData;
  final List<ItemModelSuper> snapshot;

  const HomeScreenUi(
      {Key? key, required this.wantedData, required this.snapshot})
      : super(key: key);

  @override
  _HomeScreenUiState createState() => _HomeScreenUiState();
}

class _HomeScreenUiState extends State<HomeScreenUi> {
  int _selectedIndex = 0;
  final double _expandedHeight = 150;
  late ScrollController _scrollController;
  var categoriesList = [];
  var productsList = [];

  int _selectedListWheelItem = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var element in widget.wantedData) {
      categoriesList.add(element.id);
    }

    for (var element in widget.wantedData) {
      element.data().forEach((key, value) {
        productsList.add(value);
      });
    }

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = [groceryPage(context),const CartPage(),const FarmStay()];
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: pages[_selectedIndex],

      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 1.0,
        color: Colors.transparent,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: kToolbarHeight * 1.1,
          decoration: BoxDecoration(
              gradient: Themes.farmStayAppBar,
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(25))),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  label: 'Grocery',
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('images/grocery_logo.png'),
                  )),
              BottomNavigationBarItem(
                  label: 'Cart',
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(CustomIcons.cart),
                  )),
              BottomNavigationBarItem(
                  label: 'Farm Stay',
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('images/farm_stay_logo.png'),
                  ))
            ],
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }

  Stack groceryPage(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
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
                          child: buildSearchBar(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Categories",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.175,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, top: 20),
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ParticularCategory(
                                                      category: categoriesList[
                                                          _selectedListWheelItem],
                                                      productsList: widget
                                                          .snapshot[0])));
                                    },
                                    child: ListWheelScrollView.useDelegate(
                                        squeeze: 1.2,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        perspective: 0.009,
                                        itemExtent: 200,
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            _selectedListWheelItem = index;
                                          });
                                        },
                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                                childCount:
                                                    categoriesList.length,
                                                builder: (context, index) {
                                                  return RotatedBox(
                                                      quarterTurns: 3,
                                                      child: CategoriesCard(
                                                        category:
                                                            categoriesList[
                                                                index],
                                                      ));
                                                })),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomPaint(
                                      size: Size(
                                          100,
                                          (250 * 0.5833333333333334)
                                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                      painter: RPSCustomPainter(context),
                                    ),
                                    RotatedBox(
                                      quarterTurns: 2,
                                      child: CustomPaint(
                                        size: Size(
                                            100,
                                            (250 * 0.5833333333333334)
                                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                        painter: RPSCustomPainter(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 15),
                        child: Text(
                          "Offer Products",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10, bottom: 20),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return OffersCard(
                                  product: widget.snapshot[0].map[index],
                                );
                                // return OffersCard(product: productsList[index],);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 26,
                                  ),
                              itemCount: 5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        buildCarousel()
      ],
    );
  }

  TextField buildSearchBar() {
    return TextField(
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
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.37)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(style: BorderStyle.none))),
      onChanged: (String query) {},
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
        pinned: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        expandedHeight: _expandedHeight.toDouble(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: Themes.farmStayAppBar,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17))),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Green Trench",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
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
        ]);
  }

  Widget buildCarousel() {
    //*****************************For moving the carousel along with the toolbar(ANIMATION)***********************
    var defaultTopMargin = kToolbarHeight * 0.17;
    double top = defaultTopMargin;
    if (_scrollController.hasClients) {
      setState(() {
        double offset = _scrollController.offset;
        top -= offset;
      });
    }
    return Positioned(
      top: top,
      left: 4,
      right: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 105, 20, 10),
        child: SizedBox(
          height: 210,
          width: MediaQuery.of(context).size.width * 0.95,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Carousel(
              borderRadius: true,
              boxFit: BoxFit.cover,
              autoplay: true,
              autoplayDuration: const Duration(milliseconds: 3000),
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: const Duration(milliseconds: 1000),
              dotSize: 6.0,
              dotIncreasedColor: Theme.of(context).accentColor,
              dotColor: Colors.black,
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              onImageTap: (int index) {},
              images: [
                Image.network(
                  'https://www.apkaabazar.com/storage/uploads/flipkart-super-market-2.jpg',
                  fit: BoxFit.cover,
                ),
                Image.network(
                    'https://images.freekaamaal.com/post_images/1620122066.PNG',
                    fit: BoxFit.cover),
                Image.network(
                    'https://akm-img-a-in.tosshub.com/businesstoday/images/story/201807/amazon-pantry-offer-660_071118044704.jpg',
                    fit: BoxFit.cover),
                Image.network(
                    'https://dealroup.com/wp-content/uploads/2020/05/Grocery-Offers-1024x536.jpg',
                    fit: BoxFit.cover),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final BuildContext context;

  RPSCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint0 = Paint()
      ..shader = Themes.farmStayAppBar.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 0.4975167, size.height * 0.8385000,
        size.width * 0.4991667, size.height * 0.4971429);
    path0.quadraticBezierTo(
        size.width * 0.5024167, size.height * 0.1511571, size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
