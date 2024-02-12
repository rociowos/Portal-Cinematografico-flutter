import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class TrendsPage extends StatefulWidget {
  @override
  _TrendsPageState createState() => _TrendsPageState();
}

class _TrendsPageState extends State<TrendsPage> {
  List<Movie> trendingMovies = [];

  @override
  void initState() {
    super.initState();
    getTrendingMovies();
  }

  Future<void> getTrendingMovies() async {
    try {
      http.Response response =
          await http.get(Uri.parse('http://localhost:5003/primerapi/tendencias'));
      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> parsedResponse = json.decode(response.body)['results'];
          trendingMovies = parsedResponse.map((movieData) {
            return Movie(
              title: movieData['title'],
              description: movieData['overview'],
            );
          }).toList();
        });
      } else {
        throw Exception('Error al cargar peliculas en tendencia');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tendencias'),
      ),
      body: ListView.builder(
        itemCount: trendingMovies.length,
        itemBuilder: (context, index) {
          final movie = trendingMovies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.description),
          );
        },
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
