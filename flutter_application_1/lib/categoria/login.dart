import 'dart:convert';
import 'package:http/http.dart' as http;

class Cliente {
  final String baseUrl = "https://apisflutter.onrender.com/api/cliente";

  Future<bool> login(String email, String password) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['msg'];

      for (var user in data) {
        if (user['correo'] == email && user['contrasena'] == password) {
          return true; 
        }
      }
    }

    return false; 
  }
}
