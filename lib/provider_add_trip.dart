
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gp_cic/trips.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gp_cic/Constants.dart';

class Provider_trip extends StatefulWidget {
  final String token ;
  final String imagePath;
  final String type;

  const Provider_trip({Key? key, required this.token,required this.imagePath , required this.type}) : super(key: key);
  @override
  _Provider_tripState createState() => _Provider_tripState();
}

class _Provider_tripState extends State<Provider_trip> {
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();

  var tripNameController = TextEditingController();
  var tripDescriptionController = TextEditingController();
  var tripPriceController = TextEditingController();
  var tripLocationController = TextEditingController();
  String? selectedValue;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');


  var data ='' ;
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
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0E5D4),
      appBar: AppBar(
        title: const Text(
          "Add Trip",
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  //  color: Colors.blue,
                    child: image != null ? Image.file(image!
                      ,width: 300,
                      height: 300
                      ,fit:BoxFit.fill,): const Text(
                        "Pick Image from Gallery",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      pickImage();
                    }
                ),
                const SizedBox(height: 20),

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
                  padding: const EdgeInsets.all(20),
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

                const SizedBox(height: 10),
                TextFormField(
                  controller: tripNameController,
                  decoration:const InputDecoration(
                    labelText: 'Trip name ',
                  ),
                ),

                const SizedBox(height: 10),
                 TextFormField(
                   controller: tripDescriptionController,
                  decoration:const InputDecoration(
                    labelText: 'Trip description ',
                  ),
                ),
                const SizedBox(height: 10),
                 TextFormField(
                   controller: tripLocationController,
                  decoration:const InputDecoration(
                    labelText: 'Meeting location ',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select date',
                  ),
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                        : '',
                  ),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  readOnly: true,
                  onTap: () {
                    _selectTime(context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select time',
                  ),
                  controller: TextEditingController(
                    text: selectedTime != null ? selectedTime.format(context) : '',
                  ),
                ),
                const SizedBox(height: 10),
                 TextFormField(
                   controller: tripPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Price ',
                  ),
                ),

                const SizedBox(height: 10),
                LoadingBtn(
                  height: 60,
                  borderRadius: 8,
                  animate: true,
                  color: Colors.black,
                  width: 150,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    width: 30,
                    height: 30,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  onTap: ((startLoading, stopLoading, btnState) async {
                    if (btnState == ButtonState.idle) {

                      String? name = selectedValue;
                      String tripName = tripNameController.text;
                      String description = tripDescriptionController.text;
                      String loactions = tripLocationController.text;
                      String price = tripPriceController.text;
                      final String formatted = formatter.format(selectedDate);
                      String formattedTime = DateFormat('HH:mm').format(selectedDate);
                      //  add();
                      if (image != null) {
                        startLoading();
                        await makeRequest(widget.token, tripName,image!.path, description, price, loactions, formatted, formattedTime,name!);
                        stopLoading();
                      } else {
                        showSnackBarerror("Please select a photo");
                      }
                    }
                  }),
                  child: const Text("Add Trip"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> makeRequest(String token ,String name , String filePath,String description,String price,String location , String date , String time ,String placeName) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://gp.gtss-eg.com/api/trips/create'));
    request.fields.addAll({
      'trip_name': name,
      'trip_description': description,
      'trip_price': price,
      'trip_location': location,
      'trip_time': time,
      'trip_date': date,
      'place_id': placeName
    });
    request.files.add(await http.MultipartFile.fromPath('trip_photo', filePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
     showSnackBar("Trip add successfully");
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => Trips(type: widget.type, token: widget.token, maxPrice: "", minPrice: "", placeName: "")),
     );
    }
    else {
      showSnackBar("Error in adding trip");
    }

  }

  Future<void> getData(String token) async {
    var dio = Dio();
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await Dio().get("${Constants().baseUrl}api/places/get?pagination=false",options:Options(headers:headers ));

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
  showSnackBarerror(String msg){
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
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}
