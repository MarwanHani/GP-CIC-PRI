import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:gp_cic/Constants.dart';
import 'package:gp_cic/places.dart';

import 'Models/PlacesModel.dart';
import 'RemoteServices/Api.dart';
import 'auth_screen.dart';
import 'buttons/original_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;

  const AuthForm({ required this.authType});

  @override
  State<AuthForm> createState() => AuthFormState();

}

class AuthFormState extends State<AuthForm> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  bool isLoading = false ;
  var placessController = <PlacesModel>[].obs;

 late String _selectedItem = "provider";

 final List<String> _items = [
    'guest',
    'provider'
  ];
  @override
  bool isMember = true;
  @override


  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),

              //! ###########################
              isMember
                  ? Container()
                  : TextFormField(
                key: GlobalKey(debugLabel: 'numb'),
                controller: nameController,

                decoration: const InputDecoration(labelText: 'Name'),
                    ),
              if (!isMember) const SizedBox(height: 12),
              //! ######################################
              TextFormField(
                controller: passwordController,
                key: GlobalKey(debugLabel: 'Pass'),
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              //! ######################################
              if (!isMember)
                Container(
                  width: 250,
                  child: DropdownButton<String>(
                    value: _selectedItem ,
                    items: _items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    } ,
                  ),
                ),
              if (!isMember) const SizedBox(height: 50),

              LoadingBtn(
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
                    if (isMember)  {
                      String email = emailController.text;
                      String password = passwordController.text;
                      login(email, password);
                      await Future.delayed(const Duration(seconds: 5));
                      stopLoading();
                    } else {
                      String email = emailController.text;
                      String password = passwordController.text;
                      String name = nameController.text;
                      register(email, name, password, _selectedItem);
                      await Future.delayed(const Duration(seconds: 5));
                      stopLoading();
                    }
                  }
                }),
                child: Text(isMember ? "Login" : "Register"),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isMember = !isMember;
                    });
                  },
                  child: Text(
                    widget.authType == AuthType.login
                        ? 'do not have account'
                        : 'you have account',
                  )),
            ]),
          ),
        )
      ],
    );
  }


  Future<void> login(String email, String password) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://gp.gtss-eg.com/api/user/login'));
    request.body = json.encode({
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonBody = await response.stream.bytesToString();
      final data = json.decode(jsonBody);
      String authToken = data['token'];
      String type = data['profile']['type'];
      String name = data['profile']['name'];
      String email = data['profile']['email'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Places(token: authToken,type:type ,name: name, email: email,)),
        );
    }
    else {
      final jsonBody = await response.stream.bytesToString();
      final data = json.decode(jsonBody);
      showSnackBar(data['message']);
    }
  }

  Future<void> register(String email, String name , String password , String type) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://gp.gtss-eg.com/api/user/register'));
    request.body = json.encode({
      "email": email,
      "name": name,
      "password": password,
      "type": type
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonBody = await response.stream.bytesToString();
      final data = json.decode(jsonBody);
      String authToken = data['token'];
      String type = data['profile']['type'];
      String name = data['profile']['name'];
      String email = data['profile']['email'];
      Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => Places(token: authToken,type:type ,name: name, email: email,)),
        );
    }
    else {
      final jsonBody = await response.stream.bytesToString();
      final data = json.decode(jsonBody);
       showSnackBar(data['message']);
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
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}

