import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kids_life_flutter/models/item_model.dart';

class FirebaseData extends ChangeNotifier {
  List<ItemModel> items = [];

  // Future<Iterable<ItemModelSuper>> fetchDataCollection() async {
  //   var result = await FirebaseFirestore.instance.collection('kidsLife').get().then((docs) => docs.docs.map((e) => ItemModelSuper.fromDocument(e)));
  //   return result;
  // }

  Stream<List<ItemModelSuper>> fetchDataSnapshot2() {
    var result = FirebaseFirestore.instance
        .collection('kidsLife')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => ItemModelSuper.fromDocument(e)).toList();
    });

    return result;
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> fetchDataSnapshot() {
    var result = FirebaseFirestore.instance.collection('kidsLife').snapshots();
    return result;
  }

  Stream<ItemModelSuper> fetchDataSnapshotTrial() {
    var result = FirebaseFirestore.instance.collection('kidsLife').doc('Beauty').snapshots().map((event) {
      return ItemModelSuper.fromDocument(event);
    });
    print(result);
    return result;
  }

  // fetchDataCollectionTwo() async {
  //   var result = await FirebaseFirestore.instance.collection('kidsLife').get();
  //   items = result.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();
  //   notifyListeners();
  // }


  // Iterable<ItemModelSuper> snapshotToModel(List<QueryDocumentSnapshot<Map<String,dynamic>>> docSnap){
  //   var result = docSnap.map((doc) => ItemModelSuper.fromDocument(doc));
  //   return result;
  //
  // }


}
