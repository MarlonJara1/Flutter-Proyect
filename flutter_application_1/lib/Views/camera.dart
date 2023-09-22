import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
        title: Text('Camara'),
        backgroundColor: Color.fromARGB(255, 95, 33, 143),
      ),
  
  bottomNavigationBar: BottomAppBar(
    color: Color.fromARGB(255, 88, 29, 133),
    shape: const CircularNotchedRectangle(),
    child: Container(
      height: 50.0,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          // Spacer(),
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: Icon(Icons.more_vert),
          //   onPressed: () {},
          // ),
        ],
      ),
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: _takePhoto,
    tooltip: 'Tomar foto',
    backgroundColor: Color.fromARGB(255, 67, 20, 103),
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    child: Icon(Icons.camera_alt),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  body: Column(
  children: [
    if (_image != null)
      Visibility(
        visible: _image != null,
        child: kIsWeb
            ? Image.network(_image!.path) 
            : Image.file(_image!), 
      ),
  ],
),
);

  }

  Future<void> _takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return; 

    
    setState(() {
      _image = File(image.path);
    });
  }
}
