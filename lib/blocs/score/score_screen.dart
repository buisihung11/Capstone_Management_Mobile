import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:flutter_login_demo/models/phase.dart';
import 'package:flutter_login_demo/models/score.dart';
import 'package:flutter_login_demo/models/score_template.dart';
import 'package:flutter_login_demo/utils/index.dart';

class PhaseScore extends StatefulWidget {
  final Capstone capstone;
  final Phase phase;
  const PhaseScore({Key key, this.capstone, this.phase}) : super(key: key);

  @override
  _PhaseScoreState createState() => _PhaseScoreState();
}

class _PhaseScoreState extends State<PhaseScore> {
  List<Score> scores;
  ScoreTemplate scoreTemplate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch score
    _fetchScore();
  }

  _fetchScore() async {
    final scoreRes = await request.get(
        "/capstones/${widget.capstone.id}/phases/${widget.phase.phaseId}/scores");

    // get scoreTemplate
    final scoreTemplateRes =
        await request.get("/score-templates/${widget.phase.scoreTemplateId}");

    print(scoreTemplateRes.data);

    setState(() {
      scores = Score.fromMapToList(scoreRes.data);
      scoreTemplate = ScoreTemplate.fromMap(scoreTemplateRes.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score detail"),
        backgroundColor: Colors.orange,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.replay,
                color: Colors.white,
              ),
              onPressed: () {
                _fetchScore();
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.phase.phaseName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          (scores == null || scoreTemplate == null)
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: _buildColumns(),
                      rows: _buildRows(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    final columnHeaderStyle = TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    List<DataColumn> dataCols = [
      DataColumn(
        label: Text(
          "Lecturer Name",
          style: columnHeaderStyle,
        ),
      ),
      ...scoreTemplate.listItem
          .map((e) => DataColumn(
                numeric: true,
                label: Text(
                  e.name,
                  style: columnHeaderStyle,
                ),
              ))
          .toList(),
      DataColumn(
        label: Text(
          "Feedback",
          style: columnHeaderStyle,
        ),
      )
    ];
    // scores.sc
    return dataCols;
  }

  List<DataRow> _buildRows() {
    List<DataRow> dataRows = [];
    scores.forEach((element) {
      dataRows.add(DataRow(
        cells: <DataCell>[
          DataCell(
            Text(
              element.lecturerName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...element.scores
              .map((score) => DataCell(
                    Text(score.value.toString()),
                  ))
              .toList(),
          DataCell(Text(element.feedback)),
        ],
      ));
    });

    return dataRows;
  }
}
