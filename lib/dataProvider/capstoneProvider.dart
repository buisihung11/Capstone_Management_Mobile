import 'dart:async';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:flutter_login_demo/utils/index.dart';

class CapstoneApiClient {
  CapstoneApiClient();

  Future<List<Capstone>> getCapstoneList() async {
    // get response
    final response = await request.get('/capstones');

    print(response);
    if (response.statusCode == 200) {
      // decode
      // convert to model
      final List content = response.data["content"];
      print('This is content:\n');
      print(content);
      final List<Capstone> result = new List();
      for (dynamic capstone in content) {
        result.add(Capstone.fromJson(capstone));
      }
      return result;
    } else {
      throw Exception('Failed to load capstone');
    }
  }

  Future<List<Capstone>> getCapstoneListWithFilter(String name) async {
    // get response
    final response = await request
        .get('/capstones', queryParameters: {"name_contains": name});

    print(response);
    if (response.statusCode == 200) {
      // decode
      // convert to model
      final List content = response.data["content"];
      print('This is content:\n');
      print(content);
      final List<Capstone> result = new List();
      for (dynamic capstone in content) {
        result.add(Capstone.fromJson(capstone));
      }
      return result;
    } else if (response.statusCode == 204) {
      return List<Capstone>();
    } else {
      throw Exception('Failed to load capstone');
    }
  }
}
