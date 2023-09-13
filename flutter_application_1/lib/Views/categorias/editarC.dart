import 'package:flutter/material.dart';
import 'package:flutter_application_1/categoria/categoria.dart';
import 'package:flutter_application_1/Views/categorias/listarCategoria.dart';

class EditarCategoria extends StatefulWidget {
  const EditarCategoria({
    super.key,
    required this.categoria,
  });

  final Map<String, dynamic> categoria;

  @override
  _EditarCategoriaState createState() => _EditarCategoriaState();
}

class _EditarCategoriaState extends State<EditarCategoria> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateFields();
  }

  _updateFields() {
    _nombreController.text = widget.categoria['nombreCategoria'];
    _descripcionController.text = widget.categoria['descripcionCategoria'];
    _estadoController.text = widget.categoria['estadoCategoria'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Categoría'),
        backgroundColor: Colors.black, 
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descripcionController,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _estadoController,
                        decoration: InputDecoration(
                          labelText: 'Estado',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final Map<String, dynamic> categoriaEditado = {
                            '_id': widget.categoria['_id'],
                            'nombreCategoria': _nombreController.text,
                            'descripcionCategoria': _descripcionController.text,
                            'estadoCategoria': _estadoController.text,
                          };

                          final api = Categoria();
                          try {
                            await api.editRegistro(categoriaEditado);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CategoriaP()),
                            );
                          } catch (e) {
                            print('No se modificó exitosamente');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, 
                          onPrimary: Colors.yellow, 
                        ),
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
