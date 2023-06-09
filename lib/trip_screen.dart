import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:gp_cic/trips.dart';

import 'Constants.dart';

class TripScreen extends StatefulWidget {
  final String token;
  final String type;
  const TripScreen({Key? key ,required this.token ,required this.type}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  String? selectedValue;
  var selectedCategorie = "Egypt Day Tours";
  var jsonList ;

  List<DropdownMenuItem<String>> dropDownItems = []; //* you can make nullable if you want, I'm doing it to force having String.
  List<String> placeNames=[];
  @override
  var minPrice = TextEditingController();
  var maxPrice = TextEditingController();
  void initState() {
    super.initState();
    getData(widget.token);
     for(String place in placeNames) {
       dropDownItems.add(DropdownMenuItem(child: Text(place)));
     }
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Distinations",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: DropdownButton<String>(
                value: selectedValue ,
                items: placeNames.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                } ,
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: minPrice,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Min Price",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: maxPrice,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Max Price",
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              width: double.infinity,
              child:   LoadingBtn(
                height: 60,
                borderRadius: 8,
                animate: true,
                color: Colors.black,
                width: MediaQuery.of(context).size.width * 0.45,
                loader: Container(
                  padding: const EdgeInsets.all(10),
                  width: 40,
                  height: 40,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                onTap: ((startLoading, stopLoading, btnState) async {
                  if (btnState == ButtonState.idle) {
                    startLoading();
                    // call your network api
                      String? name = selectedValue;
                      String min = minPrice.text;
                      String max = maxPrice.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Trips(type: widget.type, token: widget.token, maxPrice: max, minPrice: min,placeName: name == null ? '' : name!,)),
                    );
                      await Future.delayed(const Duration(seconds: 5));
                      stopLoading();

                  }
                }),
                child: const Text("Search"),
              ),

            ),
          ],
        ),
      ),
    );
  }
 Future<void> getData(String token) async {
    try{
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var params = {
        'pagination': false,
      };

      var response = await Dio().get(Constants().baseUrl + "api/places/get",options:Options(headers:headers ),queryParameters: params);
      if(response.statusCode == 200) {
        setState(() {
          jsonList = response.data['data'];

          List<String> resultList = List<String>.from(
            response.data['data'].map((item) => item['place_name']),
          );
          placeNames = resultList;
        });
      } else {
        jsonList = response.data['message'];
      }
    } catch(e){
      print(e);
    }
  }


}
