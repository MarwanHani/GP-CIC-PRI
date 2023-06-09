import 'package:flutter/material.dart';
import 'package:gp_cic/places.dart';
import 'package:gp_cic/places1.dart';
import 'package:gp_cic/notifications.dart';
import 'package:gp_cic/trip_screen.dart';
import 'package:gp_cic/auth_form.dart';
import 'package:gp_cic/trips.dart';
import 'auth_screen.dart';
import 'intro_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amun' ,
     home: AuthScreen(authType: AuthType.login,),
    );
  }
}

