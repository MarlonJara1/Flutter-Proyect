import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/ingredientes/listarIngrediente.dart';
import 'package:flutter_application_1/categoria/ingrediente.dart';

class CreateIngrediente extends StatefulWidget {
  @override
  _CreateIngredienteState createState() => _CreateIngredienteState();
}

class _CreateIngredienteState extends State<CreateIngrediente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  String _selectedEstado = "Activo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Ingrediente'),
        backgroundColor: Color.fromARGB(255, 67, 20, 103),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descripcionController,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa la descripción';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _precioController,
                        decoration: InputDecoration(
                          labelText: 'Precio',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa el precio';
                          }
                          final double? price = double.tryParse(value);
                          if (price == null || price < 0) {
                            return 'Por favor, ingresa un precio válido';
                          }
                          return null;
                        },
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
                          if (_formKey.currentState!.validate()) {
                            final Map<String, dynamic> crearIngrediente = {
                              'nombreIngrediente': _nombreController.text,
                              'descripcionIngrediente':
                                  _descripcionController.text,
                              'precioIngrediente': _precioController.text,
                              'estadoIngrediente': _selectedEstado,
                            };

                            final api = Ingrediente();
                            try {
                              await api.newRegistro(crearIngrediente);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const IngredienteP(),
                                ),
                              );
                            } catch (e) {
                              print('El registro no fue exitoso');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary:  Color.fromARGB(255, 67, 20, 103),

                  onPrimary: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Text(
                          'Crear',
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
