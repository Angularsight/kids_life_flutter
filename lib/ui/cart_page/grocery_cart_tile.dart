import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/provider/cart_provider.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

class GroceryCartTile extends StatelessWidget {
  final ItemModel itemModel;
  final int count;
  const GroceryCartTile({Key? key,required this.itemModel,required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryCartProvider = Provider.of<GroceryCartProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            border: Border.all(color: const Color(0xffFFE65F))),
        child: Row(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  border: Border.all(color: const Color(0xffFFE65F))),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Image.network(
                  '${itemModel.images}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("${itemModel.productName}",style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).accentColor),)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: IconButton(onPressed: () {
                            groceryCartProvider.removeGroceryFromCart(itemModel);
                          }, icon: Icon(CustomIcons.removeItem,color: Colors.white,),),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Text("Current Price :",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15,color: Colors.white),)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Rs.${itemModel.price}",style: Theme.of(context).textTheme.caption!.copyWith(fontSize:15,fontWeight: FontWeight.w300,color: Colors.white),),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Text("Sub Total :",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15,color: Colors.white),)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Rs.${double.parse(itemModel.price!) * groceryCartProvider.groceryItem[itemModel]}",style: Theme.of(context).textTheme.caption!.copyWith(fontSize:15,fontWeight: FontWeight.w300,color: Colors.white),),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Text("Quantity :",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15,color: Colors.white),)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: InkWell(
                                  onTap: (){
                                    if(groceryCartProvider.groceryItem[itemModel]==0){
                                      return;
                                    }else{
                                      groceryCartProvider.subtractFromGroceryCart(itemModel);
                                    }

                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration:  BoxDecoration(
                                      color: Color(0xffFFEE93),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(child: Text("-",style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 24),)),
                                  ),
                                ),
                              ),
                              Text("${groceryCartProvider.groceryItem[itemModel]}",style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w200),),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: InkWell(
                                  onTap: (){

                                    groceryCartProvider.addGroceryToCart(itemModel);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration:  BoxDecoration(
                                      color: Color(0xffFFEE93),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(child: Text("+",style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 24),)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
