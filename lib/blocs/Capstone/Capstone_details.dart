import 'package:flutter/material.dart';
import 'package:flutter_login_demo/blocs/score/score_screen.dart';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:flutter_login_demo/models/phase.dart';
import 'package:flutter_login_demo/utils/index.dart';

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

  List<Phase> phases;

  List selectedPhase;
  var season;
  fetchData() async {
    final response = await request.get('/capstones/${widget.capstoneId}');
    // phaseURL = '/capstones/${widget.capstoneId}/phases';
    final phaseResponse =
        await request.get('/capstones/${widget.capstoneId}/phases');
    //---------------------------------------
    // results = response.data["students"];
    List<Phase> testPhase = Phase.fromMapToList(phaseResponse.data);

    setState(() {
      capstoneDetail = Capstone.fromJson(response.data);
      phases = testPhase;
    });
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
        title: Text('Capstone detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: capstoneDetail == null
          ? Center(
              child: Text("Loading capstoneDetail",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    capstoneDetail.name,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '\nStudents: ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          children: <Widget>[
                            for (var student in capstoneDetail.students)
                              chip(
                                Text(
                                  student.name,
                                  style: TextStyle(fontSize: 13),
                                ),
                                'assets/FPT.png',
                              ),
                          ],
                        ),
                      ),
                      Text('Phase List: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 250,
                        child: phases == null
                            ? Text("Loading")
                            : GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: <Widget>[
                                  ...phases
                                      .map(
                                        (e) => Material(
                                          // color: Colors.red,
                                          child: Container(
                                            height: 50,
                                            child: InkWell(
                                              onTap: () {
                                                _onTap(e);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.amber,
                                                ),
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  '${e.phaseName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget chip(var label, String imageLink) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Chip(
        labelPadding: EdgeInsets.all(5),
        avatar: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Image.asset('$imageLink'),
        ),
        label: label,
        elevation: 3.0,
        shadowColor: Colors.grey[60],
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _onTap(Phase tappedPhase) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PhaseScore(
                capstone: capstoneDetail,
                phase: tappedPhase,
              )),
    );
  }
}
