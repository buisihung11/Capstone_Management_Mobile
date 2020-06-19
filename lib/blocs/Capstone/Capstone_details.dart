import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/capstone.dart';
class CapstonesDetails extends StatefulWidget {
  @override
  _CapstonesDetails createState() => _CapstonesDetails();
}

class _CapstonesDetails extends State<CapstonesDetails> {
  List chapters = [
    'Tam',
    'Hung'
  ];

  List topics = [
    'SE62752','SE66662'
  ];

  List major = [
    'SE', 'SE'
  ];


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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Capstone Name'.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                child: Image.asset('assets/hung.jpg'),
              ),
              title: Text(
                'Hung',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Lead Instructor',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              trailing: Text('1-1-2020'),
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
                        child: Image.asset('assets/FPT.png')
                      ),
                      //Ten sinh vien
                      title: Text(
                        chapters[index].toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //Ma so sinh vien
                      subtitle: Text(
                        topics[index],
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                        ),
                      ),
                      //Ma Major
                      trailing: Text(
                        major[index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        Text('Hoc Ky: Fall 2020')
      ],
    );
  }
}
