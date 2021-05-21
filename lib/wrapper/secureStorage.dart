import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  //CREATING STORAGE
  final storage = new FlutterSecureStorage();

  //save token
  saveToken(String token) async {
    print(token);
    await storage.write(key: 'token', value: token);
  }

  //read token
  Future<String> readToken() async {
    String token = await storage.read(key: 'token');
    return token;
  }

  //delete token
  deleteToken() async {
    //await storage.delete(key: 'token');
    await storage.deleteAll();
  }
}
