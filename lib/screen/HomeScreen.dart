import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido $userName a la pagina de peliculas!'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 1.5,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/movies');
                  },
                  icon: const Icon(Icons.movie),
                  label: const Text('Peliculas'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/genres');
                  },
                  icon: const Icon(Icons.category),
                  label: const Text('Generos'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/trends');
                  },
                  icon: const Icon(Icons.trending_up),
                  label: const Text('Tendencias'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/year_search');
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar por Año'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}