

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/provider/farm_stay_provider.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

import 'farm_stay_details_page.dart';
import 'farm_stay_home_ui.dart';
class FarmStay extends StatelessWidget {
  const FarmStay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var farmStayProvider = Provider.of<FarmStayProvider>(context);
    var farmStayDate = farmStayProvider.fetchFarmStayListSnapshot();

    return  Scaffold(

      body: StreamBuilder(
          stream: farmStayDate,
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
            if(snapshot.hasData){
              return FarmStayHomeUi(snapshot:snapshot);
            }
            print('Error : ${snapshot.error}');
            return const Center(child: CircularProgressIndicator());
      })
    );
  }


}
