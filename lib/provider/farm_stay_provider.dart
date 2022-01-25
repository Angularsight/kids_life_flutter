


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';

class FarmStayProvider extends ChangeNotifier{

  var farmStayList = [];
  String? fromDate;
  String? toDate;

  Stream<QuerySnapshot<Map<String,dynamic>>> fetchFarmStaySnapshot(){
    final result = FirebaseFirestore.instance.collection('farmStay').snapshots();
    return result;
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> fetchFarmStayListSnapshot(){
    final result = FirebaseFirestore.instance.collection('farmStay').doc('Zl8n8Lkth3lYWTkatjJV').collection('homeStayList').snapshots();
    return result;
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> fetchFarmStayDeals(String docId){
    final result = FirebaseFirestore.instance.collection('farmStay').doc('Zl8n8Lkth3lYWTkatjJV').collection('homeStayList').doc(docId).collection('deals').snapshots();
    return result;
  }

  List<IconData> stringToIcon(List<dynamic> amenities){

    List<IconData> iconList = [];
    for(int i=0;i<amenities.length;i++){
      String t = amenities[i].toString();
      CustomIcons.amenitiesMap.forEach((key, value) {
        if(t==key) iconList.add(value);
      });
    }
    return iconList;
  }

  Future<void> updateDate(String docId,String from , String to,int guests) async{
    await FirebaseFirestore.instance.collection('farmStay').doc('Zl8n8Lkth3lYWTkatjJV').update({
      'from':from,
      'to':to,
      'noOfGuests':guests
    });
  }

  Future<void> updateBookmark(String docId,bool bookmark) async{
    await FirebaseFirestore.instance.collection('farmStay').doc('Zl8n8Lkth3lYWTkatjJV').collection('homeStayList').doc(docId).update({
      'bookmark':bookmark
    });
  }



}