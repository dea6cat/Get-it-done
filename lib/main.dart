import 'package:flutter/material.dart';
import 'package:get_it_done/screens/landingpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:google_fonts/google_fonts.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get it done!',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.white,
          //textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme,),

      ),
        home: LandingPage(),
      );
  }
}
