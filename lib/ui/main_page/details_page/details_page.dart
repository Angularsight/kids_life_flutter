


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/provider/cart_provider.dart';
import 'package:kids_life_flutter/ui/main_page/details_page/product_image_half.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

class GroceryDetailsPage extends StatefulWidget {
  final ItemModel itemModel;
  const GroceryDetailsPage({Key? key,required this.itemModel}) : super(key: key);

  @override
  _GroceryDetailsPageState createState() => _GroceryDetailsPageState();
}

class _GroceryDetailsPageState extends State<GroceryDetailsPage> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groceryCartProvider = Provider.of<GroceryCartProvider>(context);

    return  Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView.builder(
              onPageChanged: (int index){},
              itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                return Image.network('${widget.itemModel.images}',fit: BoxFit.cover,);
            }),
          ),

          Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.7,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return Themes.titleBackgroundGradient.createShader(bounds);
                  },
                  child: CustomPaint(
                    size: Size(400,(400*0.5833333333333334).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter(),
                    child: Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15,left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${widget.itemModel.productName}",style: theme.textTheme.headline5,),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text("Category",style: theme.textTheme.headline3,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                Text("MRP Rs ${double.parse(widget.itemModel.price!) + double.parse(widget.itemModel.price!) * 0.15}",style: theme.textTheme.headline6,),
                                const SizedBox(width: 25,),
                                Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE25757),
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(child: Text("${widget.itemModel.offers}",style: theme.textTheme.headline3,),),

                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text("Rs.${widget.itemModel.price} (Inclusive of all taxes)",style: theme.textTheme.caption,),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.115,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: const Color(0xffC4C4C4).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(CustomIcons.location,color: const Color(0xff960F0F),size: 33,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text("Rajajinagar, Bangalore,560010",style: theme.textTheme.subtitle1,),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(CustomIcons.shipment,color: Colors.black.withOpacity(0.8),size: 33,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text("Shipment will arrive by Thursday ",style: theme.textTheme.subtitle1,),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0,bottom: 8),
                            child: Container(
                              height: 30,
                              width: 115,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                    top: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black)
                                  )
                              ),
                              child:  Center(child: Text("About Product",style: theme.textTheme.subtitle1,),),
                            ),
                          ),
                          Container(
                              height: 120,
                              width: double.infinity,
                              child: Text("${widget.itemModel.description}",
                                style:theme.textTheme.subtitle1!.copyWith(color: const Color(0xff757575)) ,))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        width: double.infinity,
        child: Row(
          children: [
            InkWell(
              onTap: (){
              },
              splashColor: Colors.red,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.07,
                color: const Color(0xffFFE13A),
                child: Center(child: Text("BUY",style: theme.textTheme.caption,)),
              ),
            ),

            itemCount==0? Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.07,
              color: const Color(0xffFFB800),
              child: InkWell(
                  onTap: (){
                    groceryCartProvider.addGroceryToCart(widget.itemModel);
                    setState(() {
                      itemCount+=1;
                    });
                  },
                  child: Center(child: Text("Add To Cart",style: theme.textTheme.caption,))),
            ):Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.07,
              color: const Color(0xffFFB800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      groceryCartProvider.subtractFromGroceryCart(widget.itemModel);
                      setState(() {
                        itemCount-=1;
                      });

                    },
                    child: Text("-",style: GoogleFonts.mavenPro(fontSize: 36,fontWeight: FontWeight.normal,color: theme.scaffoldBackgroundColor),),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1,2),
                          spreadRadius: 0,
                          blurRadius: 4
                        )
                      ]
                    ),
                    child: Center(child: Text("${groceryCartProvider.groceryItem[widget.itemModel]}",style: theme.textTheme.headline4,)),
                  ),
                  InkWell(
                    onTap: (){
                      groceryCartProvider.addGroceryToCart(widget.itemModel);
                      setState(() {
                        itemCount+=1;
                      });
                    },
                    child: Text("+",style: theme.textTheme.headline4!.copyWith(fontSize: 30,fontWeight: FontWeight.normal),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      
    );
  }
}
class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {


    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(0,0);
    path0.lineTo(0,size.height);
    path0.lineTo(size.width,size.height);
    path0.lineTo(size.width,size.height*0.0428571);
    path0.quadraticBezierTo(size.width*0.9284250,size.height*0.1579714,size.width*0.8755500,size.height*0.1589429);
    path0.cubicTo(size.width*0.7831583,size.height*0.1556571,size.width*0.7506167,size.height*0.0999857,size.width*0.7077750,size.height*0.1029286);
    path0.cubicTo(size.width*0.6344417,size.height*0.1032857,size.width*0.5620000,size.height*0.1672429,size.width*0.4995000,size.height*0.1733143);
    path0.cubicTo(size.width*0.4311667,size.height*0.1668857,size.width*0.3412083,size.height*0.0983857,size.width*0.2920417,size.height*0.0976714);
    path0.cubicTo(size.width*0.2192250,size.height*0.1004857,size.width*0.1805000,size.height*0.1662714,size.width*0.1247917,size.height*0.1663429);
    path0.quadraticBezierTo(size.width*0.0556250,size.height*0.1623429,0,0);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}










