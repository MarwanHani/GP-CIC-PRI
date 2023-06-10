import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_cic/provider_add_trip.dart';
import 'package:gp_cic/trip_screen.dart';
import 'package:http/http.dart' as http;

import 'Constants.dart';

class Trips extends StatefulWidget {
  final String type;
  final String token;
  final String minPrice;
  final String maxPrice;
  final String placeName;
  const Trips({Key? key, required this.type ,required this.token , required this.maxPrice , required this.minPrice ,required this.placeName}) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  var data;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData(widget.token, currentPage,widget.maxPrice,widget.minPrice , widget.placeName);

  }

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF0E5D4),
      appBar: AppBar(
        title: const Text(
          "Trips",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: const Color(0xffAD8B73),
        actions: [
          if (widget.type == "provider")
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Provider_trip(token : widget.token,imagePath: "",type: widget.type,)),
            );
          }, icon: const Icon(Icons.add,color: Colors.black,)),

        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TripScreen(token: widget.token,type: widget.type,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Background color
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Search"
                    ,style: TextStyle(
                      color: Colors.black,fontSize: 18
                  ),
                  ),
                )),
          ),

          Expanded(
            child: Container(
              child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: data == null ? 0 : data.length ,
          itemBuilder: (context, index) {
            final item = data[index];
            if (index < item.length) {
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
               alignment: Alignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:
                     [
                       Ink.image(
                         image: NetworkImage('${item['trip_photo']}'),
                         height: 150,
                         fit: BoxFit.cover,
                       ),

                       Text(
                         item['trip_name']
                         ,
                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                       ),
                       Container(height: 5,),

                       Text(
                         item['trip_description'],
                       ),
                       Text(
                         "From : ${item['trip_price']}\$",
                         style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                       ),
                       Center(child: ElevatedButton(
                           onPressed: (){
                            book(widget.token, item['id']);
                           },
                           style: ElevatedButton.styleFrom(
                             primary: const Color(0xffAD8B73), // Background color
                           ),
                           child: const Padding(
                             padding: EdgeInsets.symmetric(horizontal: 60),
                             child: Text("Book",style: TextStyle(color: Colors.black,fontSize: 18),),
                           ))),
                     ],
                   ),
                 )
               ]
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: loadMoreData,
                child: const Text('Load More'),
              );
            }
          }
      ),
    ),
          ),
        ],
      )
    );
  }

  void getData(String token ,int page ,String max , String min ,String placeName) async {
    try{
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var params = {
        'page': page,
        'max_price': max,
        'min_price': min,
        'place_id': placeName ,

      };
      var response = await Dio().get("${Constants().baseUrl}api/trips/get",options:Options(headers:headers ),queryParameters:
         params
          );
      if(response.statusCode == 200) {
        setState(() {
          data = response.data['data'];
        });
      } else {
        data = response.data['status'];
      }
    } catch(e){
      print(e);
    }
  }

  void loadMoreData() {
    currentPage++;
    getData(widget.token, currentPage,widget.maxPrice,widget.minPrice , widget.placeName);
  }

  void book(String token , int tripId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('https://gp.gtss-eg.com/api/bookings/create'));
    request.body = json.encode({
      "trip_id": tripId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     showSnackBar("Successfully booked");
    }
    else {
      showSnackBar("Error in booking");
    }
  }
  showSnackBar(String msg){
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Alert',
        message:
        msg,
        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
