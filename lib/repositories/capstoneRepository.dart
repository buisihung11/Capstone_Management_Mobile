import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/dataProvider/capstoneProvider.dart';
import 'package:flutter_login_demo/models/capstone.dart';

class CapstoneRepository {
  final CapstoneApiClient capstoneApiClient;

  CapstoneRepository({@required this.capstoneApiClient});

  Future<Map<String, dynamic>> getCapstoneList([int page = 0]) async {
    final result = await capstoneApiClient.getCapstoneList(page);
    return result;
  }

  Future<List<Capstone>> getCapstoneListWithFilter(String name) async {
    final result = capstoneApiClient.getCapstoneListWithFilter(name);
    return result;
  }
}
