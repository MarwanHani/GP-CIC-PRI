import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_cic/Models/PlacesModel.dart';
import 'package:gp_cic/RemoteServices/Api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PlaceDetails extends StatefulWidget {
  final jsonList;

  const PlaceDetails({Key? key, required this.jsonList}) : super(key: key);

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {

  @override
  Widget build(BuildContext context) {
    if (widget.jsonList == null) {
      // Display a loading indicator while data is being fetched
      return const CircularProgressIndicator();
    } else {
      // Display the fetched data
      return Scaffold(
        backgroundColor: const Color(0xffF0E5D4),
        appBar: AppBar(
          leading: IconButton( onPressed: (){ Navigator. pop(context); }, icon:const Icon(Icons. arrow_back_ios)), //replace with our own icon data. )
          title: const Text(
            " Place details ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.normal,
            ),
          ),
          backgroundColor: const Color(0xffAD8B73),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xffAD8B73),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: 1,
          fixedColor: Colors.black,
          selectedFontSize: 20,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView (
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), // Adjust the value to control the border radius
                    child: Image.network(
                      widget.jsonList['place_photo'], // Replace with the URL or local path of your image
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                ),

                const SizedBox(height: 50),

                Text(widget.jsonList['place_name'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Description : " + widget.jsonList['place_description'],
                  style: const TextStyle(
                    fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),
                  ),
                ),


                const SizedBox(height: 50),

                Text("Location : " + widget.jsonList['place_location']),

                const SizedBox(height: 50),

                Text("Open in : " + widget.jsonList['open_time']),


              ],
            ),
          ),
        )

    );

    }
  }

}
