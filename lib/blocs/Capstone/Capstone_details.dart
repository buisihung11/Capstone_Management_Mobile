import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/capstone.dart';

class CapstonesDetails extends StatefulWidget {
  @override
  _CapstonesDetails createState() => _CapstonesDetails();
}

class _CapstonesDetails extends State<CapstonesDetails> {
  List chapters = ['Tam', 'Hung'];

  List topics = ['SE62752', 'SE66662'];

  List major = ['SE', 'SE'];

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
            Wrap(
              spacing: 4.0,
              children: <Widget>[
                Text(
                  'Lecturer'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chip('Hung', Color(0xFFff8a65)),
                Text(
                  'Student'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chip('Tam', Color(0xFFff8a65)),
                chip('Bui Hung', Color(0xFFff8a65)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Text(
              'Fall 2020',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade600,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }
}
