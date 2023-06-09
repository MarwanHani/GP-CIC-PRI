//import 'package:amun_app/screens/auth_screen.dart';

import 'package:flutter/material.dart';

import 'buttons/original_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(),
                Image.asset('assets/image/Py.jpg'),
                originalButton(
                  text: 'get started',
                  onPressed: () {
                    Navigator.of(context).pushNamed('login');
                  },
                  textColor: Colors.white,
                  bgColor: Colors.black,
                ),
              ]),
        ),
      ),
    );
  }
}
