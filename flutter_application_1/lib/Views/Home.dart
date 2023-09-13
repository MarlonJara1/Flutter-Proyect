import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/categorias/listarCategoria.dart'; 
import 'package:flutter_application_1/Views/ingredientes/listarIngrediente.dart'; 
import 'package:flutter_application_1/Views/platos/listarPlato.dart'; 

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.black, 
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black, 
              ),
              accountName: Text('Marlon'),
              accountEmail: Text('MarlonJ@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.restaurant_menu,
                  color: Colors.black,
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
              leading: Icon(Icons.local_dining), 
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
          ],
        ),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
