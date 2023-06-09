import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Constants.dart';


class Notifications extends StatefulWidget {
  final String token;
  const Notifications({Key? key ,required this.token}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var data;

  @override
  void initState() {
    super.initState();
    getData(widget.token);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0E5D4),
      appBar: AppBar(
        leading: IconButton( onPressed: (){ Navigator. pop(context); }, icon:const Icon(Icons. arrow_back_ios)), //replace with our own icon data. )
        title: const Text(
          " Notifications",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: const Color(0xffAD8B73),
      ),
      /*
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


       */

      body: Column(
        children: [
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
                        child:  Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }


  void getData(String token ) async {
    try{
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await Dio().get("${Constants().baseUrl}api/notifications/get",options:Options(headers:headers));
      if(response.statusCode == 200) {
        setState(() {
          data = response.data['data'];
          print(data);
        });
      } else {
        data = response.data['status'];
      }
    } catch(e){
      print(e);
    }
  }




}