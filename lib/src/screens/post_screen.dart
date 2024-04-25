import 'package:flutter/material.dart';
import 'package:proyect/src/models/post.dart';
import 'package:proyect/src/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:proyect/src/models/post.dart';
import 'package:proyect/src/bloc/bloc.dart';
import 'package:proyect/src/bloc/validators.dart';

class PostScreen extends StatelessWidget with Validators {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlToImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Post'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Nuevo Post",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Text(
                bloc.userName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) => {},
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) => {},
              ),
              SizedBox(height: 10),
              TextField(
                controller: _urlToImageController,
                decoration: InputDecoration(
                  labelText: 'URL de la Imagen',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) => {},
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _validateSave(context);
                },
                child: Text('Guardar Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateSave(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final urlToImage = _urlToImageController.text;

    bool isValid = true;

    if (title.isEmpty) {
      isValid = false;
      _showErrorSnackBar(context, 'El título no puede estar vacío');
    }

    if (description.isEmpty) {
      isValid = false;
      _showErrorSnackBar(context, 'La descripción no puede estar vacía');
    }

    if (urlToImage.isEmpty) {
      isValid = false;
      _showErrorSnackBar(context, 'La URL de la imagen no puede estar vacía');
    }

    if (isValid) {
      final newPost = SocialPost(
        title: title,
        content: description,
        imageUrl: urlToImage,
        name: bloc.userName,
      );
      Navigator.pop(context, newPost);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
