class UserModel {
  String uid;
  String role;

  UserModel({
    this.uid,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON provided to SimpleObject");
    }

    return UserModel(
      uid: json['_id'],
      role: json['role'],
    );
  }
}
