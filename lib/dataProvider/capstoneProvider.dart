import 'dart:async';
import 'dart:convert';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:flutter_login_demo/utils/index.dart';

class CapstoneApiClient {
  static const baseUrl = "https://fucapstone.azurewebsites.net/api";
  final request = MyRequest();
  CapstoneApiClient();

  Future<List<Capstone>> getCapstoneList() async {
    // get response
    final response = await request.request.get('locationUrl');

    print(response);
    return null;
    // if (response.statusCode == 200) {
    //   // decode
    //   // convert to model
    //   final List content = decodebody["content"];
    //   final List<Capstone> result = new List();
    //   for (dynamic capstone in content) {
    //     result.add(Capstone.fromJson(capstone));
    //   }
    //   print('$content["capstoneId"]');
    //   return result;
    // } else {
    //   throw Exception('Failed to load capstone');
    // }
  }
}
