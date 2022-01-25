

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FarmStayCartProvider extends ChangeNotifier{
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> farmStayList = [];
  bool isAddedToCart = false;
  double subTotal = 0;
  double total = 0;


  void addFarmToCart(QueryDocumentSnapshot<Map<String, dynamic>> snapshot){
    if(farmStayList.contains(snapshot)) {
      return;
    } else {
      farmStayList.add(snapshot);
      notifyListeners();
    }

  }

  void removeFarmFromCart(int index){
    farmStayList.removeAt(index);
    notifyListeners();
  }

  void emptyCart(){
    for (var element in farmStayList) {
      print(element.id);
      updateFirebaseDatabase(element.id, false);
    }
    farmStayList.clear();
    notifyListeners();
  }

  Future<void> updateFirebaseDatabase(String docId,bool bookmark)async{
    await FirebaseFirestore.instance.collection('farmStay').doc('Zl8n8Lkth3lYWTkatjJV').collection('homeStayList').doc(docId).update({
      'bookmark':bookmark
    });
  }

}