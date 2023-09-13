import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/ingredientes/crearIng.dart';
import 'package:flutter_application_1/Views/ingredientes/editarIng.dart';
import 'package:flutter_application_1/categoria/ingrediente.dart';

class IngredienteP extends StatefulWidget {
  const IngredienteP({super.key});

  @override
  State<IngredienteP> createState() => _IngredientePState();
}

class _IngredientePState extends State<IngredienteP> {
  late Future<List<Map<String, dynamic>>> obtenerIngrediente;

  @override
  void initState() {
    super.initState();
    obtenerIngrediente = _extraerDatos();
  }

  Future<List<Map<String, dynamic>>> _extraerDatos() async {
    final datos = await Ingrediente().obtenerDatos();
    return List<Map<String, dynamic>>.from(datos['ingredientes']);
  }

  void refrescarDatos() {
    setState(() {
      obtenerIngrediente = _extraerDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ingredientes'),
        backgroundColor: Colors.black, // Cambia el color del AppBar a negro
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerIngrediente,
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
            final List<Map<String, dynamic>> ingredientes =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: ingredientes.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Card(
                      elevation: 3, // Añade sombra a la tarjeta
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margen
                      child: ListTile(
                        title: Text(
                          ingredientes[index]['nombreIngrediente'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descripción: ${ingredientes[index]['descripcionIngrediente']}'),
                            Text('Precio: ${ingredientes[index]['precioIngrediente']}'),
                            Text('Estado: ${ingredientes[index]['estadoIngrediente']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditarIngrediente(ingrediente: ingredientes[index])),
                                );
                              },
                              icon: Icon(Icons.edit),
                              color: const Color.fromARGB(255, 100, 100, 100), // Cambia el color del ícono de edición
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Color.fromARGB(255, 241, 216, 24), // Cambia el color del ícono de eliminación
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Eliminar visitante'),
                                      content: const Text(
                                          '¿Está seguro que desea eliminar este visitante?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final api = Ingrediente();
                                            Map<String, dynamic> eliminarDato = {
                                              '_id': ingredientes[index]['_id']
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
            MaterialPageRoute(builder: (context) => CreateIngrediente()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black, // Cambia el color del botón flotante
      ),
    );
  }
}
