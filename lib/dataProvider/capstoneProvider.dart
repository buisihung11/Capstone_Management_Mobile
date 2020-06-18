import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_demo/models/capstone.dart';

class CapstoneApiClient {
  static const baseUrl = "https://fucapstone.azurewebsites.net/api";
  Client client = Client();

  CapstoneApiClient({@required this.client});

  Future<List<Capstone>> getCapstoneList() async {
    final String locationUrl = '$baseUrl/capstones';

    // get response
    final response = await client
        .get('https://fucapstone.azurewebsites.net/api/capstones?Page=1');

    // decode
    final decodebody = json.decode(response.body);
    // convert to model
    final List content = decodebody["content"];
    final List<Capstone> result = new List();
    for (dynamic capstone in content) {
      result.add(Capstone.fromJson(capstone));
    }
    print('$content["capstoneId"]');
    if (response.statusCode == 200) {
      return <Capstone>[
        //Capstone.fromJson(json.decode())
      ];
    } else {
      throw Exception('Failed to load capstone');
    }
  }
}
