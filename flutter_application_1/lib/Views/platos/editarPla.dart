import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/platos/listarPlato.dart';
import 'package:flutter_application_1/categoria/plato.dart';

class EditarPlato extends StatefulWidget {
  const EditarPlato({
    super.key,
    required this.plato,
  });

  final Map<String, dynamic> plato;

  @override
  _EditarPlatoState createState() => _EditarPlatoState();
}

class _EditarPlatoState extends State<EditarPlato> {
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
    _nombreController.text = widget.plato['nombrePlato'];
    _descripcionController.text = widget.plato['descripcionPlato'];
    _precioController.text = widget.plato['precioPlato'].toString();
    _selectedEstado = widget.plato['estadoPlato'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Plato'),
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
                          final Map<String, dynamic> platoEditado = {
                            '_id': widget.plato['_id'],
                            'nombrePlato': _nombreController.text,
                            'descripcionPlato': _descripcionController.text,
                            'precioPlato': _precioController.text,
                            'estadoPlato': _selectedEstado,
                          };

                          final api = Plato();
                          try {
                            await api.editRegistro(platoEditado);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlatoP()),
                            );
                          } catch (e) {
                            print('No se modificó correctamente');
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
