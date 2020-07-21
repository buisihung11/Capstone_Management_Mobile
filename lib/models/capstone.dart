import 'dart:convert';

class Student {
  final String name;
  final String studentId;

  Student({this.name, this.studentId});

  factory Student.fromMap(Map<String, dynamic> map) => Student(
        name: map["name"],
        studentId: map["studentId"],
      );
}

class Capstone {
  final int id;
  final String name;
  final String mentorName;
  final String currentPhase;
  final String dateCreate;
  final List<Student> students;

  Capstone({
    this.students,
    this.id,
    this.name,
    this.mentorName,
    this.currentPhase,
    this.dateCreate,
  });

  factory Capstone.fromJson(Map<String, dynamic> json) => new Capstone(
        id: json["capstoneId"],
        name: json["name"],
        mentorName: json["mentor"]["name"],
        currentPhase: json["dateCreated"],
        dateCreate: json["dateCreated"],
        students: json["students"] != null
            ? List<Student>.from(
                json["students"].map((student) => Student.fromMap(student)))
            : [],
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
