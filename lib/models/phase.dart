import 'package:flutter/widgets.dart';

class Phase {
  final String phaseName;
  final int phaseId;
  final int capstoneId;
  final String dateStart;
  final bool isPublished;
  final String status;
  final int order;
  final String dateEnd;
  final int scoreTemplateId;

  Phase(
      {this.phaseName,
      @required this.phaseId,
      @required this.capstoneId,
      this.dateStart,
      this.isPublished,
      this.status,
      this.order,
      this.dateEnd,
      this.scoreTemplateId});
  //  listLecture: []

  factory Phase.fromMap(Map<String, dynamic> map) => Phase(
        phaseId: map["phaseId"],
        capstoneId: map["capstoneId"],
        phaseName: map["phaseName"],
        dateStart: map["dateStart"],
        isPublished: map["isPublished"],
        status: map["status"],
        order: int.parse(map["order"].toString()),
        dateEnd: map["dateEnd"],
        scoreTemplateId: int.parse(map["scoreTemplateId"].toString()),
      );

  static List<Phase> fromMapToList(List<dynamic> listMap) =>
      List<Phase>.from(listMap.map((e) => Phase.fromMap(e)));
}
