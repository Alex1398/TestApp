import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './services/device_characteristics.dart';
import './screens/connect_your_wallet_screen.dart';

void main() async {
  // initialize firebase for entire app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await Firebase.initializeApp();
  // Get device proportions
  DeviceCharacteristics.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConnectYourWalletScreen(),
      routes: {
        ConnectYourWalletScreen.routeName: (ctx) =>
            const ConnectYourWalletScreen(),
      },
    );
  }
}
