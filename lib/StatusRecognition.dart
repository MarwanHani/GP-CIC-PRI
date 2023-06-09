
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gp_cic/Constants.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/services.dart';

class StatuseRecognition extends StatefulWidget {

final String token;
  const StatuseRecognition({Key? key, required this.token}) : super(key: key);

  @override
  _StatusRecognitionState createState() => _StatusRecognitionState();
}

class _StatusRecognitionState extends State<StatuseRecognition> {

  @override
  void initState(){
    super.initState();
    loadModel();
  }

  File? image;
  List? results;
  bool imageSelect=false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      imageClassification(imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      imageClassification(imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future imageClassification(File? _image) async {
    var recognition = await Tflite.runModelOnImage(path: image!.path , numResults: 6,threshold: 0.05, imageMean: 127.5,imageStd: 127.5);
    setState(() {
      results = recognition!;
      image=_image;
      imageSelect=true;
    });
  }

  Future loadModel() async {
    try {
      String? res;
      res = await Tflite.loadModel(
          model: "assets/model.tflite", labels: "assets/labels.txt");
      print("loading model status : $res ");
    } catch (e) {
      print("error + $e");
    }
  }

  late String imagePath = '';
  late String statusName = '';


  @override
  Widget build(BuildContext context) {

      // Display the fetched data
      return Scaffold(
        backgroundColor: const Color(0xffF0E5D4),
        appBar: AppBar(
          leading: IconButton( onPressed: (){ Navigator. pop(context); }, icon:const Icon(Icons. arrow_back_ios)), //replace with our own icon data. )
          title: const Text(
            " Status recognition ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.normal,
            ),
          ),
          backgroundColor: const Color(0xffAD8B73),
        ),
        body: Padding(
          padding: const EdgeInsets.all(100.0),
          child: SingleChildScrollView (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  //  color: Colors.blue,
                    child: const Text(
                        "Pick Image from Gallery",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      setState(() {
                        image = null;
                        statusName = '';
                      });
                      pickImage();
                    }
                ),

                MaterialButton(
                  //  color: Colors.blue,
                    child: const Text(
                        "Capture photo with camera",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      setState(() {
                        image = null;
                        statusName = '';
                      });
                      pickImageC();
                    }
                ),

                const SizedBox(height: 10),

                SingleChildScrollView(
                  child: Column(
                   children: [
                 if (results != null) Card(
                  child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        image != null ? Image.file(image!): const Text("No image selected"),
                        const SizedBox(height: 20,),
                        Text(
                           "${results![0]['label']} - ${results![0]['confidence'].toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.red,
                              fontSize: 20),
                        ) ,
                      ],
                    ),
                  ),
                ),
               ) else const Text("No image selected"),
              ],
                  ),
                ),
/*
                SingleChildScrollView(
                  child: Column(
                    children: [

                      image != null ? Image.file(image!): const Text("No image selected"),

                       Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${results[0]['label']} - ${results[0]['confidence'].toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.red,
                                fontSize: 20),
                          ),
                        ),
                      ),
                     ]
                  ),
                ),


 */
                /*
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
                      startLoading();
                    await makeRequest(widget.token, image!.path);
                      stopLoading();
                    }
                  }),
                  child: const Text("Analyz"),
                ),
                const SizedBox(height: 10),

                image != null ? Image.file(image!): const Text("No image selected"),

                const SizedBox(height: 20),

                statusName != '' ? Text(statusName
                , style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ) : const Text("")


                 */
              ],
            ),
          ),
        )
    );


  }

 Future<void> makeRequest(String token , String filePath) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://gp.gtss-eg.com/api/temples/analyze'));
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);

      String message = jsonData['message'];
      showSnackBar(message);
      setState(() {
        imagePath = jsonData['result_image'];
        statusName = jsonData['result_label'];
      });

    } else {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);

      String message = jsonData['message'];
      showSnackBarerror(message);

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

  showSnackBarerror(String msg ){
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
