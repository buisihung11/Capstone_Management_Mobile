import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_demo/models/capstone.dart';

class CapstoneApiClient {
  static const baseUrl = "";
  final HttpClient client;

  CapstoneApiClient({@required this.client});

  Future<List<Capstone>> getCapstoneList() async {
    final String locationUrl = '$baseUrl/capstones';

    // get response

    // decode

    // convert to model
    return Future.delayed(Duration(seconds: 2), () {
      return <Capstone>[
        new Capstone(
          currentPhase: "Review Doc",
          id: "1",
          mentorName: "ThanhPC",
          name: "Capstone Management",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
        new Capstone(
          currentPhase: "Bao ve lan 1",
          id: "2",
          mentorName: "PhuongLK",
          name: "Bus tracking FPT",
        ),
      ];
    });
  }
}
