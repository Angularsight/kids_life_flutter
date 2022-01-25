import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/provider/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({Key? key}) : super(key: key);

  @override
  _HomeScreen3State createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<FirebaseData>(context);
    return Scaffold(
      body: StreamBuilder(
          stream: itemProvider.fetchDataSnapshotTrial(),
          builder: (context, AsyncSnapshot<ItemModelSuper> snapshot) {
            print(snapshot.data!.map[0].productName);
            return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: snapshot.data!.map.length,
                    itemBuilder: (context,index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("productName:${snapshot.data!.map[index].productName}"),
                          ),
                          Text("price : ${snapshot.data!.map[index].price}"),
                          Text("description : ${snapshot.data!.map[index].description}")
                        ],
                      );
                })

            );
          }),
    );
  }
}
