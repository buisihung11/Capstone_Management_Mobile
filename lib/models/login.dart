class LoginResponse {
  final dynamic data;
  final String error;
  final bool success;

  LoginResponse({this.data, this.error, this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
        data: json["data"],
        error: json["error"],
        success: json["success"],
      );
}
