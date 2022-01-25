import 'package:cloud_firestore/cloud_firestore.dart';


class ItemModelSuper {
  final List<ItemModel> map;

  ItemModelSuper({required this.map});

  factory ItemModelSuper.fromDocument(DocumentSnapshot<Map<String,dynamic>>? doc){
    final map = doc!.data();
    final newMap = <ItemModel>[];

    map!.forEach((key,dynamic value) {
      newMap.add(ItemModel.fromJson(value));
    });
    return ItemModelSuper(map: newMap);
  }

}
class ItemModel {
  String? productName;
  String? price;
  String? quantity;
  String? offers;
  String? images;
  String? description;
  bool? bookmark;
  int count = 0;

  ItemModel(
      {this.productName,
      this.price,
      this.quantity,
      this.offers,
      this.images,
      this.description});

  factory ItemModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data();
    return ItemModel(
        productName: map!['productName'],
        price: map['price'],
        quantity: map['quantity'],
        offers: map['offers'],
        images: map['images'],
        description: map['description']);
  }

  ItemModel.fromJson(Map snapshot) {
    productName = snapshot['productName'] ?? '';
    price = snapshot['price'] ?? '';
    quantity = snapshot['quantity'] ?? '';
    offers = snapshot['offers'] ?? '';
    images = snapshot['images'] ?? '';
    description = snapshot['description'] ?? '';
  }

  Map toJson() {
    final Map data = {};
    data['productName'] = productName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['offers'] = offers;
    data['images'] = images;
    data['description'] = description;

    return data;
  }
}
