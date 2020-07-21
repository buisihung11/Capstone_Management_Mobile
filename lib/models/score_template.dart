class ScoreTemplate {
  final int scoreTemplateId;
  final String name;
  final List<ScoreItem> listItem;

  ScoreTemplate({this.scoreTemplateId, this.name, this.listItem});

  factory ScoreTemplate.fromMap(Map<String, dynamic> map) => ScoreTemplate(
        name: map["name"],
        scoreTemplateId: map["scoreTemplateId"],
        listItem: List<ScoreItem>.from(
            map["listItem"].map((e) => ScoreItem.fromMap(e))),
      );
}

class ScoreItem {
  final String name;
  final int scoreTemplateItemId;
  final double weight;
  ScoreItem({this.name, this.weight, this.scoreTemplateItemId});

  factory ScoreItem.fromMap(Map<String, dynamic> map) => ScoreItem(
      name: map["name"],
      scoreTemplateItemId: map["scoreTemplateItemId"],
      weight: map["weight"]);
}
