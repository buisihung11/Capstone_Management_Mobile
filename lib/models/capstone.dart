import 'dart:convert';
class Capstone {
  final int id;
  final String name;
  final String mentorName;
  final String currentPhase;

  Capstone({this.id, this.name, this.mentorName, this.currentPhase});

  factory Capstone.fromJson(Map<String, dynamic> json) => new Capstone(
    id: json["capstoneId"],
    name: json["name"],
    mentorName: json["lectureId"],
    currentPhase: json["seasonId"],
  );

  Map<String, dynamic> toJson() => {
        "capstoneId": id,
        "name": name,
        "lectureId": mentorName,
        "seasonId": currentPhase,
    };

    

List<Capstone> capstoneFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Capstone>.from(jsonData.map((x) => Capstone.fromJson(x)));
}

String capstoneToJson(List<Capstone> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}
}
