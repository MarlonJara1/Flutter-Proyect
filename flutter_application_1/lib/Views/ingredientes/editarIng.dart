import 'package:flutter/material.dart';
import 'package:flutter_application_1/categoria/ingrediente.dart';
import 'package:flutter_application_1/Views/ingredientes/listarIngrediente.dart';

class EditarIngrediente extends StatefulWidget {
  const EditarIngrediente({
    super.key,
    required this.ingrediente,
  });

  final Map<String, dynamic> ingrediente;

  @override
  _EditarIngredienteState createState() => _EditarIngredienteState();
}

class _EditarIngredienteState extends State<EditarIngrediente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  String _selectedEstado = "Activo";

  @override
  void initState() {
    super.initState();
    _updateFields();
  }

  _updateFields() {
    _nombreController.text = widget.ingrediente['nombreIngrediente'];
    _descripcionController.text = widget.ingrediente['descripcionIngrediente'];
    _precioController.text = widget.ingrediente['precioIngrediente'].toString();
    _selectedEstado = widget.ingrediente['estadoIngrediente'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Ingrediente'),
        backgroundColor: Colors.black, // Cambia el color del AppBar a negro
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
                  color: Colors.white, // Color de fondo de la tarjeta
                  borderRadius: BorderRadius.circular(10.0), // Radio de borde de la tarjeta
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
                        controller: _precioController,
                        decoration: InputDecoration(
                          labelText: 'Precio',
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedEstado,
                        onChanged: (value) {
                          setState(() {
                            _selectedEstado = value!;
                          });
                        },
                        items: ["Activo", "Inactivo"].map((estado) {
                          return DropdownMenuItem<String>(
                            value: estado,
                            child: Text(estado),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Estado',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final Map<String, dynamic> ingredienteEditado = {
                            '_id': widget.ingrediente['_id'],
                            'nombreIngrediente': _nombreController.text,
                            'descripcionIngrediente': _descripcionController.text,
                            'precioIngrediente': _precioController.text,
                            'estadoIngrediente': _selectedEstado, // Usar el estado seleccionado
                          };

                          final api = Ingrediente();
                          try {
                            await api.editRegistro(ingredienteEditado);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const IngredienteP()),
                            );
                          } catch (e) {
                            print('No se modificó correctamente');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Cambia el color del botón
                          onPrimary: Colors.yellow, // Cambia el color del texto del botón
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
