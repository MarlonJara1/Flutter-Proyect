import 'package:flutter/material.dart';

import 'package:flutter_application_1/categoria/categoria.dart';

class CategoriaP extends StatefulWidget {
  const CategoriaP({super.key});

  @override
  State<CategoriaP> createState() => _CategoriaPState();
}

class _CategoriaPState extends State<CategoriaP> {
  late Future<List<Map<String, dynamic>>> obtenerCategoria;

  @override
  void initState() {
    super.initState();
    obtenerCategoria = _extraerDatos();
  }

  Future<List<Map<String, dynamic>>> _extraerDatos() async {
    final datos = await Categoria().obtenerDatos();
    return List<Map<String, dynamic>>.from(datos['categorias']);
  }

  void refrescarDatos() {
    setState(() {
      obtenerCategoria = _extraerDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        backgroundColor: Color.fromARGB(255, 67, 20, 103),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerCategoria,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Map<String, dynamic>> categorias =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          categorias[index]['nombreCategoria'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descripción: ${categorias[index]['descripcionCategoria']}'),
                            Text('Estado: ${categorias[index]['estadoCategoria']}'),
                          ],
                        ),
                        
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      height: 16.0,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      
    );
  }
}
