import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/categorias/listarCategoria.dart';
import 'package:flutter_application_1/Views/ingredientes/listarIngrediente.dart';
import 'package:flutter_application_1/Views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Material App',
      home: LoginScreen (),
    );
  }
}
