import 'dart:convert';

class Student {
  String name;
  String id;

  Student({this.name, this.id});

  factory Student.fromJson(Map<String, dynamic> json) => new Student(
        id: json["studentId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": id,
        "name": name,
      };

  List<Student> capstoneFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Student>.from(jsonData.map((x) => Student.fromJson(x)));
  }

  String capstoneToJson(List<Student> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
