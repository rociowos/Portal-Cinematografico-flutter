import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];
  int currentPage = 1;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPeliculas(currentPage);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    filterMovies(_searchController.text);
  }

  void filterMovies(String query) {
    setState(() {
      filteredMovies = movies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> getPeliculas(int page) async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://localhost:5003/primerapi/estrenos'));
      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> parsedResponse = json.decode(response.body)['results'];
          movies.addAll(parsedResponse.map((movieData) {
            return Movie(
              title: movieData['title'],
              description: movieData['overview'],
            );
          }));
          
          filteredMovies.addAll(movies);
        });
      } else {
        throw Exception('Error al cargar peliculas: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al cargar peliculas: $error');
    }
  }

  Future<void> loadNextPage() async {
    currentPage++;
    await getPeliculas(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar película',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
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
}

class Movie {
  final String title;
  final String description;

  Movie({
    required this.title,
    required this.description,
  });
}
