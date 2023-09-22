import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/camera.dart';
import 'package:flutter_application_1/Views/categorias/listarCategoria.dart';
import 'package:flutter_application_1/Views/ingredientes/listarIngrediente.dart';
import 'package:flutter_application_1/Views/platos/listarPlato.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 67, 20, 103),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              accountName: Text('Marlon'),
              accountEmail: Text('MarlonJ@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 67, 20, 103),
                child: Icon(
                  Icons.restaurant_menu,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categorías'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriaP()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.apple),
              title: Text('Ingredientes'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IngredienteP()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Platos'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlatoP()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Cámara'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'Categorías',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryCard(
                  context,
                  'Categoría 1',
                  'Descripción de Categoría 1',
                  Icons.category,
                  Color.fromARGB(255, 136, 42, 207),
                ),
                _buildCategoryCard(
                  context,
                  'Categoría 2',
                  'Descripción de Categoría 2',
                  Icons.category,
                  Color.fromARGB(255, 136, 42, 207),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryCard(
                  context,
                  'Categoría 3',
                  'Descripción de Categoría 3',
                  Icons.category,
                  Color.fromARGB(255, 136, 42, 207),
                ),
                _buildCategoryCard(
                  context,
                  'Categoría 4',
                  'Descripción de Categoría 4',
                  Icons.category,
                  Color.fromARGB(255, 136, 42, 207),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
        border: Border.all(color: color, width: 2), // Borde morado
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.black, // Icono y texto morado
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            color: Colors.black, // Icono y texto morado
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: color, // Texto morado
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
