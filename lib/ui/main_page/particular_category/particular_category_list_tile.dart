import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/provider/cart_provider.dart';
import 'package:kids_life_flutter/provider/farm_stay_cart_provider.dart';
import 'package:kids_life_flutter/ui/main_page/details_page/details_page.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

class ParticularCategoryListTile extends StatefulWidget {
  final ItemModel? productDetails;
  ParticularCategoryListTile({Key? key, this.productDetails}) : super(key: key);

  @override
  State<ParticularCategoryListTile> createState() =>
      _ParticularCategoryListTileState();
}

class _ParticularCategoryListTileState
    extends State<ParticularCategoryListTile> {
  var cartItemCount = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groceryCartProvider = Provider.of<GroceryCartProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroceryDetailsPage(
                        itemModel: widget.productDetails!,
                      )));
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration:
              BoxDecoration(color: theme.scaffoldBackgroundColor, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, -5),
                blurRadius: 4,
                spreadRadius: 0)
          ]),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 250,
                  child: Image.network(
                    '${widget.productDetails!.images}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            height: 50,
                            child: Text(
                              "${widget.productDetails!.productName}",
                              style: theme.textTheme.caption!
                                  .copyWith(color: Color(0xffDFC94F)),
                            ),
                          ),
                          if (cartItemCount == 0) IconButton(
                                  icon: Icon(
                                    CustomIcons.cart,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    groceryCartProvider.addGroceryToCart(widget.productDetails!);
                                    setState(() {
                                      cartItemCount++;
                                    });
                                  },
                                ) else buildAddToCart(context, theme,widget.productDetails!)
                        ],
                      ),
                      Text(
                        "Type : Raw",
                        style: theme.textTheme.headline2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "MRP : ${double.parse('${widget.productDetails!.price}') + 100}",
                            style: theme.textTheme.headline2,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Offer:",
                                style: theme.textTheme.headline2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: Themes.titleBackgroundGradient),
                                  child: Center(
                                      child: Text(
                                    "  ${widget.productDetails!.offers}",
                                    style: theme.textTheme.subtitle1!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  )),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Color(0xffFFEE93),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            child: Center(
                                child: Text(
                              "Rs ${widget.productDetails!.price}/${widget.productDetails!.quantity}",
                              style: theme.textTheme.caption!
                                  .copyWith(fontSize: 16),
                            )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddToCart(BuildContext context, ThemeData theme, ItemModel itemModel) {

    final groceryCartProvider = Provider.of<GroceryCartProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              groceryCartProvider.subtractFromGroceryCart(itemModel);
              setState(() {
                cartItemCount -= 1;
              });
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Center(
                child: Text(
                  "-",
                  style: GoogleFonts.mavenPro(
                      fontSize: 36,
                      fontWeight: FontWeight.normal,
                      color: theme.scaffoldBackgroundColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade50,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 1),
                        spreadRadius: 0,
                        blurRadius: 4)
                  ]),
              child: Center(
                  child: Text(
                "${groceryCartProvider.groceryItem[itemModel]}",
                style: theme.textTheme.headline4,
              )),
            ),
          ),
          InkWell(
            onTap: () {
              groceryCartProvider.addGroceryToCart(itemModel);
              setState(() {
                cartItemCount += 1;
              });
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Text(
                "+",
                style: theme.textTheme.headline4!
                    .copyWith(fontSize: 30, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
