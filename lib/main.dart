import 'package:country_code_picker/country_code.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kids_life_flutter/provider/cart_provider.dart';
import 'package:kids_life_flutter/provider/farm_stay_provider.dart';
import 'package:kids_life_flutter/provider/firebase_provider.dart';
import 'package:kids_life_flutter/provider/farm_stay_cart_provider.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen_2.dart';
import 'package:kids_life_flutter/ui/main_page/home_screen_3.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/forgot_password.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/otp_page.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/reset_password.dart';
import 'package:kids_life_flutter/ui/splash_screen_and_onboarding/splash_screen.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:provider/provider.dart';

import 'models/item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FirebaseData()),
        ChangeNotifierProvider(create: (_)=>FarmStayProvider()),
        ChangeNotifierProvider(create: (_)=>FarmStayCartProvider()),
        ChangeNotifierProvider(create: (_)=>GroceryCartProvider()),
        //This fetches a variable from firebase whose
        StreamProvider<List<ItemModelSuper>>(
            create: (_) => FirebaseData().fetchDataSnapshot2(),
            initialData: const [],

        )
      ],
      builder: (context,child){
        return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Kids Life Farm',
            theme: Themes().themeData(),
            home:  const HomeScreen());
      },
    );
  }
}
