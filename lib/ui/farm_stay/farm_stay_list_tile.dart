// ignore_for_file: must_be_immutable

// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/provider/farm_stay_provider.dart';
import 'package:kids_life_flutter/provider/farm_stay_cart_provider.dart';
import 'package:kids_life_flutter/ui/farm_stay/farm_stay_details_page.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

class FarmStayListTile extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
  bool isAddedToCart;
  FarmStayListTile({Key? key, required this.snapshot,required this.isAddedToCart}) : super(key: key);

  @override
  State<FarmStayListTile> createState() => _FarmStayListTileState();
}

class _FarmStayListTileState extends State<FarmStayListTile> {


  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final List amenities = widget.snapshot.data()['amenities'];
    final amenityIcons = FarmStayProvider().stringToIcon(amenities);


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
              gradient: Themes.farmStayAppBar,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(CustomIcons.holiday),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${widget.snapshot.data()['name']}",
                          style: t.textTheme.caption,
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: InkWell(
                    //     onTap: (){
                    //       if(widget.isAddedToCart) {
                    //         farmStayCart.removeFarmFromCart(farmStayCart.farmStayList.indexOf(widget.snapshot));
                    //       } else {
                    //         farmStayCart.addFarmToCart(widget.snapshot);
                    //       }
                    //       setState(() {
                    //         bookmark = !bookmark;
                    //       });
                    //
                    //     },
                    //     child: CircleAvatar(
                    //       backgroundColor: t.scaffoldBackgroundColor,
                    //       radius: 14,
                    //       child: bookmark?Icon(
                    //         CustomIcons.bookmark2,
                    //         size: 20,
                    //       ):Icon(
                    //         CustomIcons.bookmark,
                    //         size: 20,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      CustomIcons.location2,
                      color: Colors.red.shade700,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.snapshot.data()['location']}",
                      style: t.textTheme.caption!.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      CustomIcons.home,
                      color: Colors.black,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.snapshot.data()['homeStayType']}',
                      style: t.textTheme.caption!.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: buildImageCarousel(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            gradient: Themes.transparentGradient,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      CustomIcons.check,
                                      color: const Color(0xff1D6F00),
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Free cancellation - Full Board",
                                      style: t.textTheme.caption!.copyWith(
                                          color: const Color(0xff1D6F00),
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Text('Rs.${widget.snapshot.data()['price']}',
                                        style: TextStyle(
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 4),
                                            ],
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.black)),
                                    Expanded(
                                      child: Text('/Night',
                                          style: TextStyle(shadows: [
                                            Shadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: const Offset(0, 2),
                                                blurRadius: 4),
                                          ], fontSize: 8, color: Colors.black)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color(0xff75B15F),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "View Deal",
                                                style: t.textTheme.headline2!
                                                    .copyWith(fontSize: 10),
                                              ),
                                            ),
                                            Icon(
                                              CustomIcons.right,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          ],
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top Amenities",
                              style:
                                  t.textTheme.headline3!.copyWith(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 38,
                              width: 110,
                              child: OrientationBuilder(
                                builder: (BuildContext context, Orientation orientation) {
                                  return GridView.builder(
                                    itemCount: amenityIcons.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 5,
                                          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 5),
                                      itemBuilder: (context, index) {
                                        return Icon(amenityIcons[index],size: 10,);
                                      });
                                },
                              ),

                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildImageCarousel(BuildContext context) {
    List<Image> image = [];
    for(int i =0;i<widget.snapshot.data()['images'].length;i++){
      image.add(Image.network(widget.snapshot.data()['images'][i],fit: BoxFit.cover,));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.75,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Carousel(
          borderRadius: true,
          boxFit: BoxFit.cover,
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: const Duration(milliseconds: 1000),
          dotSize: 6.0,
          dotIncreasedColor: Theme.of(context).accentColor,
          dotColor: Colors.black,
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.bottomCenter,
          dotVerticalPadding: 2,
          showIndicator: true,
          indicatorBgPadding: 7.0,
          onImageTap: (int index) {},
          images: image
        ),
      ),
    );
  }
}
