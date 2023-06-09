import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gp_cic/Constants.dart';

import '../Models/PlacesModel.dart';


class PlacesRemoteService {
  static Future<dynamic> fetchPlacess (String token) async {
    try {
      var request = http.Request('GET', Uri.parse('https://gp.gtss-eg.com/api/places/get'));

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse = await request.send();
      var response1 = await http.Response.fromStream(streamedResponse);
      var response = utf8.decode(response1.bodyBytes);
      //debugPrint("response $response");
      Map responseMap = json.decode(response);
        var data = jsonEncode(responseMap['data']);
        return placesModelFromJson(data);

    } on Exception catch (e) {
      debugPrint('FAILED 2 $e', wrapWidth: 1024);
      if (e.toString().contains('Failed host')) {

      }
    }
  }

  Future<List<dynamic>> fetchData(String token) async {
    final response = await http.get(Uri.parse('https://gp.gtss-eg.com/api/places/get'));
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    if (response.statusCode == 200) {
      // Parse the response body using jsonDecode
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}