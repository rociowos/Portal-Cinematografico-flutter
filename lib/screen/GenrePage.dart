import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class GenrePage extends StatefulWidget {
  const GenrePage({super.key});

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  List<Genre> genres = [];

  @override
  void initState() {
    super.initState();
    getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Géneros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return ListTile(
                    title: Text(genre.name),
                    subtitle: Text('ID: ${genre.id}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getGenres() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://10.0.2.2:5003/primerapi/generos'));
      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> parsedResponse =
              json.decode(response.body)['genres'];
          genres = parsedResponse.map((genreData) {
            return Genre(
              id: genreData['id'],
              name: genreData['name'],
            );
          }).toList();
        });
      } else {
        throw Exception('Error al cargar generos');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}


class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });
}
