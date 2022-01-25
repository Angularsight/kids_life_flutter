



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:kids_life_flutter/models/item_model.dart';
import 'package:kids_life_flutter/provider/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:io';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  late List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    final itemProviderTwo = Provider.of<FirebaseData>(context);

    return Scaffold(
        body: StreamBuilder(
            stream: itemProviderTwo.fetchDataSnapshot2(),
            builder: (context,AsyncSnapshot<List<ItemModelSuper>> snapshot){
              if(snapshot.hasData){
                return SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: Text('${snapshot.data![0]}')),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }


            )
    );
  }
}
