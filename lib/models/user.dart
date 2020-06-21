class User {
  final String displayName;
  final String email;
  final String pictureUrl;
  final String role;
  final String userId;

  User({this.displayName, this.email, this.pictureUrl, this.role, this.userId});

  factory User.fromJSON(Map<String, dynamic> json) => new User(
        displayName: json["displayName"],
        email: json["email"],
        pictureUrl: json["pictureUrl"],
        role: json["role"],
        userId: json["userId"],
      );
}
