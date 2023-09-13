import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Home.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black, // Cambia el color del AppBar a negro
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                '', // Reemplaza 'URL_DE_LA_IMAGEN' con la URL de tu imagen
                width: 120,
                height: 120,
              ),
              SizedBox(height: 30),
              Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Color del borde
                  borderRadius: BorderRadius.circular(10.0), // Radio de borde
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: InputBorder.none, // Elimina el borde del campo de texto
                    prefixIcon: Icon(Icons.person),
                    
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Color del borde
                  borderRadius: BorderRadius.circular(10.0), // Radio de borde
                ),
                child: TextFormField(
                  obscureText: true, // Ocultar la contraseña
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: InputBorder.none, // Elimina el borde del campo de texto
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Cambia el color del botón a negro
                  onPrimary: Colors.yellow, // Cambia el color del texto a amarillo
                ),
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
