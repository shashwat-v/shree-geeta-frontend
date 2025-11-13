class RegisterResponse {
  final String message;
  final String username;
  final int id;

  RegisterResponse({
    required this.message,
    required this.username,
    required this.id,
  });

  factory RegisterResponse.fromJSON(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['msg'],
      username: json['username'],
      id: json['id'],
    );
  }
}
