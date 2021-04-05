import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungmitrphol/states/authen.dart';
import 'package:ungmitrphol/states/check_workgroup.dart';
import 'package:ungmitrphol/states/create_account.dart';
import 'package:ungmitrphol/states/show_chart.dart';
import 'package:ungmitrphol/states/show_map.dart';
import 'package:ungmitrphol/states/show_result.dart';

Map<String, WidgetBuilder> map = {
  '/showResult': (BuildContext context) => ShowResult(),
  '/authen': (BuildContext context) => Authen(),
  '/checkWorkgroup': (BuildContext context) => CheckWorkGroup(),
  '/showCart': (BuildContext context) => ShowChart(),
  '/createAccount':(BuildContext context)=>CreateAccount(),
  '/showMap':(BuildContext context)=>ShowMap(),
};

String initialRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/showResult';
        runApp(MyApp());
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
