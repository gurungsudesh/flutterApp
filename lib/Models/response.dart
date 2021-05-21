class Response {
  String msg;
  String token;
  String role;

  Response({this.msg, this.role, this.token});

  factory Response.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON provided to SimpleObject");
    }

    return Response(msg: json['msg'], role: json['role'], token: json['token']);
  }
}
