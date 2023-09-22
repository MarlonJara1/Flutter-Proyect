import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/platos/crearPla.dart';
import 'package:flutter_application_1/Views/platos/editarPla.dart';
import 'package:flutter_application_1/categoria/plato.dart';

class PlatoP extends StatefulWidget {
  const PlatoP({super.key});

  @override
  State<PlatoP> createState() => _PlatoPState();
}

class _PlatoPState extends State<PlatoP> {
  late Future<List<Map<String, dynamic>>> obtenerPlato;

  @override
  void initState() {
    super.initState();
    obtenerPlato = _extraerDatos();
  }

  Future<List<Map<String, dynamic>>> _extraerDatos() async {
    final datos = await Plato().obtenerDatos();
    return List<Map<String, dynamic>>.from(datos['platos']);
  }

  void refrescarDatos() {
    setState(() {
      obtenerPlato = _extraerDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Platos'),
        backgroundColor: Color.fromARGB(255, 67, 20, 103),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: obtenerPlato,
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
            final List<Map<String, dynamic>> platos =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: platos.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Card(
                      elevation: 3, 
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                      child: ListTile(
                        title: Text(
                          platos[index]['nombrePlato'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descripción: ${platos[index]['descripcionPlato']}'),
                            Text('Precio: ${platos[index]['precioPlato']}'),
                            Text('Estado: ${platos[index]['estadoPlato']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditarPlato(plato: platos[index])),
                                );
                              },
                              icon: Icon(Icons.edit),
                              color: const Color.fromARGB(255, 100, 100, 100), 
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Color.fromARGB(255, 67, 20, 103), 
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Eliminar plato'),
                                      content: const Text(
                                          '¿Está seguro que desea eliminar este plato?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final api = Plato();
                                            Map<String, dynamic> eliminarDato = {
                                              '_id': platos[index]['_id']
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
            MaterialPageRoute(builder: (context) => CreatePlato()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 67, 20, 103), 
      ),
    );
  }
}
