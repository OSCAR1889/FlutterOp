import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApi extends StatefulWidget {
  @override
  _MyApiState createState() => _MyApiState();
}

class _MyApiState extends State<MyApi> {
  late Future<List<Character>> _charactersList;

 Future<List<Character>> _fetchCharacters() async {
  final Uri url = Uri.parse("https://rickandmortyapi.com/api/character");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    List<Character> charactersList = [];
    for (var character in jsonData['results']) { // Acceder a 'results'
      final name = character['name'];
      final gender = character['gender'] ?? '';
      final type = character['species'] ?? '';
      final image = character['image'] ?? '';
      charactersList.add(Character(
        name: name,
        gender: gender,
        type: type,
        image: image,
      ));
    }
    return charactersList;
  } else {
    throw Exception("Failed to load characters");
  }
}


  @override
  void initState() {
    super.initState();
    _charactersList = _fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty Characters'),
      ),
      body: FutureBuilder(
        future: _charactersList,
        builder: (context, AsyncSnapshot<List<Character>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            List<Character> charactersList = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.lightBlueAccent],
                ),
              ),
              child: ListView.builder(
                itemCount: charactersList.length,
                itemBuilder: (context, index) {
                  return _buildCharacterCard(charactersList[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCharacterCard(Character character) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nombre: ${character.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Género: ${character.gender}",
                    style: TextStyle(fontSize: 14,color: Colors.white,),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Tipo: ${character.type}",
                    style: TextStyle(fontSize: 14,color: Colors.white,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Character {
  final String name;
  final String gender;
  final String type;
  final String image;

  Character({
    required this.name,
    required this.gender,
    required this.type,
    required this.image,
  });
}


