import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp_cic/Models/PlacesModel.dart';
import 'package:gp_cic/RemoteServices/Api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:gp_cic/placeDetails.dart';

import 'Constants.dart';

class Places3 extends StatefulWidget {
  final String token ;

  const Places3({Key? key, required this.token}) : super(key: key);

  @override
  _Places3State createState() => _Places3State();
}

class _Places3State extends State<Places3> {

  var jsonList;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData(widget.token, currentPage);
  }
  @override
  Widget build(BuildContext context) {
   // if (jsonList == null) {
      // Display a loading indicator while data is being fetched
   //   return const CircularProgressIndicator();
   // } else {
      // Display the fetched data
      return Scaffold(
        backgroundColor: const Color(0xffF0E5D4),
        appBar: AppBar(
          leading: IconButton( onPressed: (){ Navigator. pop(context); }, icon:const Icon(Icons. arrow_back_ios)), //replace with our own icon data. )
          title: const Text(
            " Temple Places ",
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
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (context, index) {
            final item = jsonList[index];
            final image = item["place_photo"];
            if (index < item.length) {
              return Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Ink.image(
                        image: NetworkImage('${item['place_photo']}'),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PlaceDetails(jsonList: jsonList[index])),
                            );
                          },
                        ),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Text(
                          item['place_name']
                          ,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              letterSpacing: 1.0,
                              wordSpacing: 2.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }
          },
        ),
    );
  }

   void getData(String token ,int page) async {
    try{
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var params = {
        'page':page,
      };
      var response = await Dio().get(Constants().baseUrl + "api/places/get",options:Options(headers:headers ),queryParameters: params);
        if(response.statusCode == 200) {
          setState(() {
            jsonList = response.data['data'];
          });
        } else {
          jsonList = response.data['message'];
        }
    } catch(e){
      print(e);
    }

   }
  void loadMoreData() {
    currentPage++;
    getData(widget.token, currentPage );
  }

}
