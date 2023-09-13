import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Plato{
  final String url = "https://back-cnji.onrender.com/api/plato";
  Future <Map<String,dynamic>>obtenerDatos()async{
    final respuesta = await http.get (Uri.parse(url));
    if(respuesta.statusCode == 200){
      return jsonDecode(respuesta.body);
    }else{
      throw Exception("Error en la solicitud");
    }
  }

  Future <void> newRegistro(Map<String,dynamic>agregar)async{
    final respuesta = await http.post (Uri.parse(url),headers: {'Content-Type':'application/json'},
    body: jsonEncode(agregar) );
    if(respuesta.statusCode == 200){
      return jsonDecode(respuesta.body);
    }else{
      throw Exception("Error en la solicitud");
    }
  }

  Future <void> editRegistro(Map<String,dynamic>editar)async{
    final respuesta = await http.put (Uri.parse(url),headers: {'Content-Type':'application/json'},
    body: jsonEncode(editar));
    if(respuesta.statusCode == 200){
      return jsonDecode(respuesta.body);
    }else{
      throw Exception("Error en la solicitud");
    }
  }

  Future <void> deleRegistro(Map<String,dynamic>eliminar)async{
    final respuesta = await http.delete (Uri.parse(url),headers: {'Content-Type':'application/json'},
    body: jsonEncode(eliminar) );
    if(respuesta.statusCode == 200){
      print(respuesta.body);
      return jsonDecode(respuesta.body);
    }else{
      throw Exception("Error en la solicitud");
    }
  }

}