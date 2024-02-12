import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class YearSearchPage extends StatefulWidget {
  @override
  _YearSearchPageState createState() => _YearSearchPageState();
}

class _YearSearchPageState extends State<YearSearchPage> {
  List<Movie> moviesByYear = [];
  TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar por Año'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Año',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _searchMoviesByYear();
            },
            child: Text('Buscar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: moviesByYear.length,
              itemBuilder: (context, index) {
                final movie = moviesByYear[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchMoviesByYear() async {
    final year = _yearController.text;
    try {
      http.Response response = await http.get(Uri.parse('http://localhost:5003/primerapi/anio/$year'));
      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> parsedResponse = json.decode(response.body)['results'];
          moviesByYear = parsedResponse.map((movieData) {
            return Movie(
              title: movieData['title'],
              description: movieData['overview'],
            );
          }).toList();
        });
      } else {
        throw Exception('Error al cargar peliculas por año');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class Movie {
  final String title;
  final String description;

  Movie({
    required this.title,
    required this.description,
  });
}
