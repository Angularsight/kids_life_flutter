import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kids_life_flutter/provider/farm_stay_cart_provider.dart';
import 'package:kids_life_flutter/provider/farm_stay_provider.dart';
import 'package:kids_life_flutter/ui/farm_stay/payment_page.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

class FarmStayDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> farmStaySnapshot;
  final Stream<QuerySnapshot<Map<String, dynamic>>> deals;
  final String? fromDate;
  final String? toDate;
  final int? guests;

  const FarmStayDetails({Key? key, required this.deals, required this.farmStaySnapshot, this.fromDate, this.toDate, this.guests,}) : super(key: key);

  @override
  State<FarmStayDetails> createState() => _FarmStayDetailsState();
}

class _FarmStayDetailsState extends State<FarmStayDetails> with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  bool confirmedBooking = false;
  late TabController _tabController;
  late bool bookmark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    bookmark = widget.farmStaySnapshot.data()['bookmark'];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Theme.of(context);
    // LinearGradient blueGradient =  LinearGradient(colors: [const Color(0xff6FBABF),const Color(0xff233539).withOpacity(0.76)]);
    final farmStayCartProvider = Provider.of<FarmStayCartProvider>(context);
    final farmStayProvider =Provider.of<FarmStayProvider>(context);


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: widget.deals,
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: PageView.builder(
                        onPageChanged: (int index) {},
                        itemCount: widget.farmStaySnapshot.data()['images'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.farmStaySnapshot.data()['images'][index],
                            fit: BoxFit.cover,
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.32),
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: CustomPaint(
                          size: Size(400, (400 * 0.5833333333333334).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSCustomPainter(),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15,
                                left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 100,
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: Text(
                                              "${widget.farmStaySnapshot.data()['name']}",
                                              style: theme.textTheme.headline5!
                                                  .copyWith(fontSize: 20),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            farmStayCartProvider.addFarmToCart(widget.farmStaySnapshot);
                                            bookmark = !bookmark;
                                            farmStayProvider.updateBookmark(widget.farmStaySnapshot.id, bookmark);
                                            setState(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: t.scaffoldBackgroundColor,
                                            radius: 15,
                                            child: bookmark?Icon(
                                              CustomIcons.bookmark2,
                                              size: 22,
                                            ):Icon(
                                              CustomIcons.bookmark,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.101,
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                        gradient: Themes.transparentGradient,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                CustomIcons.location,
                                                color: const Color(0xff960F0F),
                                                size: 33,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "${widget.farmStaySnapshot.data()['location']}",
                                                  style:
                                                      theme.textTheme.subtitle1,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                CustomIcons.home,
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                size: 33,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "${widget.farmStaySnapshot.data()['homeStayType']}",
                                                  style:
                                                      theme.textTheme.subtitle1,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TabBar(
                                  onTap: (int index) {
                                    _selectedTabIndex = index;
                                  },
                                  isScrollable: true,
                                  enableFeedback: false,
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                      color: const Color(0xff5DD200),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            offset: const Offset(1, 2),
                                            blurRadius: 4,
                                            spreadRadius: 0)
                                      ]),
                                  indicatorPadding: const EdgeInsets.all(5),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Tab(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Deals",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Info",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Reviews",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          "All Photos",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width: double.infinity,
                                  child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        dealsWidget(snapshot),
                                        infoWidget(context, snapshot),
                                        reviewsWidget(),
                                        allPhotosWidget()
                                      ]),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  confirmedBooking?Positioned(
                      bottom: 0,
                      child: confirmBookingWidget(context,snapshot)):
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            confirmedBooking = true;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xff5DD200),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(child:Text("Confirm Booking",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 17,fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    ),
                  )

                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget dealsWidget(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {


    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            List offerOptions = snapshot.data!.docs[index].data()['offerOptions'];

            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      gradient: Themes.transparentGradient,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${snapshot.data!.docs[index].data()['typeOfOffer']}",
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.8),
                                      offset: const Offset(1, 2),
                                      blurRadius: 4)
                                ],
                                fontSize: 18,),
                          ),
                        ),

                        const SizedBox(height: 5,),
                        for(int i=0;i<offerOptions.length;i++)
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 10,
                                  width: 120,
                                  child: Text(offerOptions[i].toString(),style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 10
                                  ),),
                                ),
                                Icon(CustomIcons.check,color: Colors.green,size: 15,)
                              ],
                            ),
                        const SizedBox(height: 2,),

                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Coupon Code :",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(letterSpacing: 2, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: buildSearchBar()),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MRP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: const Color(0xff818181),
                                            fontSize: 9,
                                          ),
                                    ),
                                    Text(
                                      "Rs.${snapshot.data!.docs[index].data()['mrp'] + 100}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: const Color(0xff818181),
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: const Color(0xffFF4D4D),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Rs.${snapshot.data!.docs[index].data()['currentPrice']}/Night',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
          itemCount: snapshot.data!.docs.length),
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: const BoxDecoration(),
      child: TextField(
        showCursor: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            fillColor: const Color(0xffE5E5E5),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Colors.transparent, style: BorderStyle.none))),
        onChanged: (String query) {},
      ),
    );
  }

  Widget infoWidget(BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Text(
                  "${widget.farmStaySnapshot.data()['homeStayInfo']}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 18),
                ),
              ),
            )
          ],
        ));
  }

  Widget reviewsWidget() {
    return Container();
  }

  Widget allPhotosWidget() {
    return Container();
  }

  Widget confirmBookingWidget(BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient:  Themes.farmStayAppBar,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0,-4),
            blurRadius: 4,
            spreadRadius: 0
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 10,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Deal",style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: const Color(0xff7E0000),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("Standard Suite",style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 17,
                  ),),
                ),
                Row(
                  children: [
                    Text("No of Rooms : ",style: Theme.of(context).textTheme.subtitle1,),
                    Text("${(widget.guests! / 4).round()}",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold,fontSize: 17),)
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0,bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildPrimaryInfoTablet(context,'From',CustomIcons.calender,Colors.green),
                  buildPrimaryInfoTablet(context, 'To',CustomIcons.calender,Colors.red),
                  buildPrimaryInfoTablet(context, 'Guests',CustomIcons.people,Colors.purple)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      confirmedBooking = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child:Text("Back",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 17,fontWeight: FontWeight.bold),)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FarmStayPaymentPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff5DD200),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child:Text("Book Now",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 17,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            )

          ],
        ),

      ),
    );
  }
  buildPrimaryInfoTablet(BuildContext context,String text,IconData icon,Color color){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Icon(icon,color: color,),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text,style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w200
                ),),
                if (text=='Guests') widget.guests==null?const Text("--",style: TextStyle(
                    fontSize: 12,
                    color: Colors.black)):Text(widget.guests.toString(),style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black))
                else if(text=='From') Text(widget.fromDate!,style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black))
                else  Text(widget.toDate!,style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint0 = Paint()
      ..shader = Themes.farmStayAppBar.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width, size.height * 0.0428571);
    path0.quadraticBezierTo(size.width * 0.9284250, size.height * 0.1579714,
        size.width * 0.8755500, size.height * 0.1589429);
    path0.cubicTo(
        size.width * 0.7831583,
        size.height * 0.1556571,
        size.width * 0.7506167,
        size.height * 0.0999857,
        size.width * 0.7077750,
        size.height * 0.1029286);
    path0.cubicTo(
        size.width * 0.6344417,
        size.height * 0.1032857,
        size.width * 0.5620000,
        size.height * 0.1672429,
        size.width * 0.4995000,
        size.height * 0.1733143);
    path0.cubicTo(
        size.width * 0.4311667,
        size.height * 0.1668857,
        size.width * 0.3412083,
        size.height * 0.0983857,
        size.width * 0.2920417,
        size.height * 0.0976714);
    path0.cubicTo(
        size.width * 0.2192250,
        size.height * 0.1004857,
        size.width * 0.1805000,
        size.height * 0.1662714,
        size.width * 0.1247917,
        size.height * 0.1663429);
    path0.quadraticBezierTo(
        size.width * 0.0556250, size.height * 0.1623429, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
