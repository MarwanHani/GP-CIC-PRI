import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_cic/auth_form.dart';
import 'package:gp_cic/auth_screen.dart';

import 'Constants.dart';


class Profile extends StatefulWidget {
  final String name ;
  final String email ;
  final String type ;
  final String token ;

  const Profile({Key? key , required this.name , required this.email , required this.type , required this.token}) : super(key: key);


  @override
  _ProfileState createState() => _ProfileState();

}
class _ProfileState extends State<Profile> {

  var data;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData(widget.token);

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF0E5D4),
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen(authType: AuthType.login,)),
            );
          }, icon: const Icon(Icons.logout,color: Colors.black,)),

        ],

        backgroundColor: const Color(0xffAD8B73),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              color: Colors.white,
              child: Column(
                children:
                [
                   Text(
                    "Name  : " + widget.name ,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Container(height: 5,),
                   Text(
                    "Type  : " + widget.type ,
                    style:const TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Container(height: 5,),
                   Text(
                    "Email : " + widget.email,
                    style:const TextStyle(
                      fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              "My Booking",
              style: TextStyle(
                fontSize: 20,
                 fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10,),

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
                                        image: NetworkImage('${item['trip']['trip_photo']}'),
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),

                                      Text(
                                        "Code : " + item['code']
                                        ,
                                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                       "Name : " + item['trip']['trip_name']
                                        ,
                                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      ),
                                      Container(height: 5,),

                                      Text(
                                        "Description : " +  item['trip']['trip_description'],
                                      ),
                                      Text(
                                        "Price : ${item['trip']['trip_price']}\$",
                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                        "Location : ${item['trip']['trip_location']}",
                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                        "Date : ${item['trip']['trip_date']}",
                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ]
                          ),
                        );
                      }
                    }
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void getData(String token ) async {
    try{
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await Dio().get("${Constants().baseUrl}api/bookings/get/own",options:Options(headers:headers ));
    print(response.statusCode);
    print(response.data);
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
}
