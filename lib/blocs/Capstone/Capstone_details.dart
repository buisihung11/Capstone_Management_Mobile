import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:flutter_login_demo/utils/index.dart';

import 'Capstone_phases.dart';

class CapstonesDetails extends StatefulWidget {
  final int capstoneId;
  final int currentPhase;

  const CapstonesDetails({
    Key key,
    @required this.capstoneId,
    this.currentPhase,
  }) : super(key: key);
  @override
  _CapstonesDetails createState() => _CapstonesDetails();
}

class _CapstonesDetails extends State<CapstonesDetails> {
  Capstone capstoneDetail;
  String phaseURL;
  List results = [];
  List phases = [];
  List selectedPhase;
  var season;
  fetchData() async {
    final response = await request.get('/capstones/${widget.capstoneId}');
    phaseURL = '/capstones/${widget.capstoneId}/phases';
    final phaseResponse = await request.get(phaseURL);
    print('this is castone detail');
    print(response.data);
    //---------------------------------------
    results = response.data["students"];
    print('this is result');
    print(results);
    print('This is length');
    print('${results.length}');
    //----------------------------------------
    print('this is phase');
    phases = phaseResponse.data;
    print(phases);
    int length = phases.length;
    phases = [];
    for (int i = 0; i < length; i++) {
      phases.add(phaseResponse.data[i]["phaseName"]);
    }

    print(selectedPhase);
    //this is season
    season = response.data["season"]["name"];
    setState(() {
      capstoneDetail = Capstone.fromJson(response.data);
    });

    print(capstoneDetail);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

//-------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Capstone detail', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: capstoneDetail == null
          ? Center(
              child: Text("Loading capstoneDetail"),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(capstoneDetail.name +
                      '\n------------------------------------------'),
                  Text(
                    "ID: ${widget.capstoneId.toString()} \n ${widget.currentPhase}",
                  ),
                  Wrap(
                    spacing: 4.0,
                    children: <Widget>[
                      Text(
                        '\nMade by: '.toUpperCase(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      for (var student in results)
                        chip(student["name"], 'assets/FPT.png'),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: <Widget>[
                              DataTable(
                                columns: [
                                  DataColumn(label: Text('Phase Name')),
                                ],
                                rows: phases
                                    .map(
                                      (e) => DataRow(cells: [
                                        DataCell(
                                          Text(
                                            e,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor:
                                                    Colors.amber[100]),
                                          ),
                                          onTap: () => _onTap(phaseURL, 1),
                                        ),
                                      ]),
                                    )
                                    .toList(),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            season == null
                ? Center(
                    child: Text(""),
                  )
                : Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      season,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget chip(var label, String imageLink) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade600,
        child: Image.asset('$imageLink'),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  void _onTap(String phaseURL, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhaseDetails(
          url: phaseURL,
          id: id,
        ),
      ),
    );
  }
}
