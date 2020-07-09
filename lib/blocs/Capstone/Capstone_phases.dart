import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:flutter_login_demo/utils/index.dart';

import 'Capstone_phases.dart';

class PhaseDetails extends StatefulWidget {
  final String url;
  final int id;
  const PhaseDetails({
    Key key,
    @required this.url,
    this.id,
  }) : super(key: key);

  @override
  _PhaseDetailsState createState() => _PhaseDetailsState();
}

class _PhaseDetailsState extends State<PhaseDetails> {
  List chapters = [
    'Introduction',
    'Adobe XD',
    'Sketch Basics',
    'Figma Mastery',
  ];

  List topics = [
    'Introduction to the course',
    'Detailed tutorials on adobe XD',
    'Introduction to the course',
    'Sketch beginner to expert series',
    'Figma from basic to advanced',
  ];
  fetchData() async {
    final response = await request.get('${widget.url}');
    print(response);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Phase Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Design Tool Bundle'.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                backgroundColor: Colors.grey[300],
              ),
              title: Text(
                'Frederick Hemmings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Lead Instructor',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chapters.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0, 0),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text(
                          '$index',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        chapters[index].toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        topics[index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
