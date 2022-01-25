import 'package:flutter/cupertino.dart';
import 'package:kids_life_flutter/models/item_model.dart';

class GroceryCartProvider extends ChangeNotifier{

  var groceryItem = {};




  void addGroceryToCart(ItemModel itemModel){
    if(groceryItem.containsKey(itemModel)){
      groceryItem[itemModel] +=1;
    }else{
      groceryItem[itemModel] = 1;
    }
    notifyListeners();
  }


  void subtractFromGroceryCart(ItemModel itemModel){
    if(groceryItem.containsKey(itemModel)){
      groceryItem[itemModel] -=1;
    }
    notifyListeners();
  }

  void removeGroceryFromCart(ItemModel itemModel){
    groceryItem.remove(itemModel);
    notifyListeners();
  }

  void clearCart(){
    groceryItem.clear();
    notifyListeners();
  }

  double getTotalAmount(){
    var totalAmount = 0.0;
    groceryItem.forEach((key, value) {
      totalAmount += double.parse(key.price!)*value;
    });
    return totalAmount;
  }

}