import 'package:flutter_login_demo/models/score_item.dart';

class Score {
  final String lecturerId;
  final String lecturerName;
  final String feedback;
  final int feedbackId;
  final List<ScoreItem> scores;

  Score(
      {this.lecturerId,
      this.lecturerName,
      this.feedback,
      this.feedbackId,
      this.scores});

  factory Score.fromMap(Map<String, dynamic> map) => new Score(
      lecturerId: map["lecturerId"],
      lecturerName: map["lecturerName"],
      feedback: map["feedback"],
      feedbackId: int.parse(map["feedbackId"].toString()),
      scores: new List<ScoreItem>.from(
          map["scores"].map((score) => ScoreItem.fromMap(score))));

  static List<Score> fromMapToList(List<dynamic> listMap) =>
      List<Score>.from(listMap.map((e) => Score.fromMap(e)));
  // Map<String, dynamic> toJson() => {
  //       "studentScoreId": studentScoreId,
  //       "scoreTemplateItemId": scoreTemplateItemId,
  //       "scoreTemplateItemName": scoreTemplateItemName,
  //       "value": value,
  //     };
}
