import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/ui/main_page/details_page/details_page.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';

class OffersCard extends StatefulWidget {
  // final Map<String,dynamic>? product;
  final ItemModel? product;
  const OffersCard({Key? key, this.product}) : super(key: key);

  @override
  _OffersCardState createState() => _OffersCardState();
}

class _OffersCardState extends State<OffersCard> {


  final WIDTH = 200.0;
  @override
  Widget build(BuildContext context) {
    var pr = widget.product;
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>GroceryDetailsPage(itemModel:widget.product!)));
      },
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              width: 200,

              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                  radius: 30,
                  // child: ClipOval(child: Image.network('${pr!['images']}'))),
                child: ClipOval(child: Image.network('${pr!.images}'),),
            ),

            )
          ),

          Container(
            height: 190,
            width: 200,
            decoration:  BoxDecoration(
              gradient: Themes.farmStayAppBar,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(2,5)
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height:50,
                          width: 150,
                          // child: Text("${pr['productName']}",style: Theme.of(context).textTheme.headline4,),
                          child: Text("${pr.productName}",style: Theme.of(context).textTheme.headline4,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                          child: Center(child: Text("${pr.offers}",style: Theme.of(context).textTheme.headline2,),),
                        ),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3),
                  child: Text("Owner : Ramesh",style: Theme.of(context).textTheme.headline3,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical:3),
                  child: Text("Manufactured On : 12/12/21",style: Theme.of(context).textTheme.headline3,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3,right: 2,bottom: 10,left: 10),
                  child: Row(
                    children: [
                      Text("Expiry Date : ",style: Theme.of(context).textTheme.headline3,),
                      Container(
                          height: 30,
                          width: 100,
                          child: Text("Best before 12 days",style: Theme.of(context).textTheme.headline3,)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(CustomIcons.star,color: Theme.of(context).scaffoldBackgroundColor,),
                          const SizedBox(width: 5,),
                          Text("4.5",style: Theme.of(context).textTheme.headline3,)
                        ],
                      ),
                    ),

                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                      ),
                      // child: Center(child: Text("Rs ${pr['price']}/${pr['quantity']}",style: Theme.of(context).textTheme.headline2,)),
                      child: Center(child:Text("Rs ${pr.price} / ${pr.quantity}",style: Theme.of(context).textTheme.headline2,)),
                    )
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
class RPSCustomPainter extends CustomPainter{
  final BuildContext context;

  RPSCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color(0xff1C4F14)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(size.width*0.0008333,0);
    path0.quadraticBezierTo(size.width*0.0212417,size.height*0.4454571,size.width*0.5024917,size.height*0.4568857);
    path0.quadraticBezierTo(size.width*0.9841583,size.height*0.4347429,size.width*0.9991667,size.height*0.0028571);
    path0.lineTo(size.width,size.height);
    path0.quadraticBezierTo(size.width*0.2416667,size.height*1.0246429,0,size.height);
    path0.quadraticBezierTo(size.width*-0.0081250,size.height*0.7757143,size.width*0.0008333,0);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}






