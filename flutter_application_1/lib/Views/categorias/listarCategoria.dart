import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/categorias/crearC.dart';
import 'package:flutter_application_1/Views/categorias/editarC.dart';
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
        backgroundColor: Colors.black,
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditarCategoria(categoria: categorias[index])),
                                );
                              },
                              icon: Icon(Icons.edit),
                              color: const Color.fromARGB(255, 100, 100, 100),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Color.fromARGB(255, 241, 216, 24),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Eliminar categoría'),
                                      content: const Text(
                                          '¿Está seguro que desea eliminar esta categoría?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final api = Categoria();
                                            Map<String, dynamic> eliminarDato = {
                                              '_id': categorias[index]['_id']
                                            };
                                            await api.deleRegistro(eliminarDato);
                                            Navigator.of(context).pop();
                                            refrescarDatos();
                                          },
                                          child: const Text('Eliminar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateCategoria()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
