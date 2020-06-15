import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/dataProvider/capstoneProvider.dart';
import 'package:flutter_login_demo/models/capstone.dart';

class CapstoneRepository {
  final CapstoneApiClient capstoneApiClient;

  CapstoneRepository({@required this.capstoneApiClient});

  Future<List<Capstone>> getCapstoneList() async {
    final result = capstoneApiClient.getCapstoneList();
    return result;
  }
}
