class ScoreItem {
  final int studentScoreId;
  final int scoreTemplateItemId;
  final String scoreTemplateItemName;
  final double value;

  ScoreItem(
      {this.studentScoreId,
      this.scoreTemplateItemId,
      this.scoreTemplateItemName,
      this.value});

  factory ScoreItem.fromMap(Map<String, dynamic> map) => new ScoreItem(
        studentScoreId: map["studentScoreId"],
        scoreTemplateItemId: map["scoreTemplateItemId"],
        scoreTemplateItemName: map["scoreTemplateItemName"],
        value: double.parse(map["value"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "studentScoreId": studentScoreId,
        "scoreTemplateItemId": scoreTemplateItemId,
        "scoreTemplateItemName": scoreTemplateItemName,
        "value": value,
      };
}
