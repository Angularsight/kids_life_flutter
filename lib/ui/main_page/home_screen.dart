



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/provider/firebase_provider.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/home_screen_ui.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<FirebaseData>(context);
    return Scaffold(
      body: StreamBuilder(
          stream: itemProvider.fetchDataSnapshot(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
            if(snapshot.hasData){
              var wantedData = snapshot.data!.docs;
              var wantedResult = snapshot.data!.docs.map((doc) => ItemModelSuper.fromDocument(doc)).toList();
              return SizedBox(
                  height: double.infinity,
                  width:  double.infinity,
                  // child: Center(child: Text("${wantedData.data().values}")));
                  child:  HomeScreenUi(wantedData: wantedData,snapshot: wantedResult,)
              );
            }
            return const Center(child: CircularProgressIndicator());
      })
    );
  }
}
