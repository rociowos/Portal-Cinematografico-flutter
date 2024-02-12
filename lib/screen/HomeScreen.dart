import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final String userName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Bienvenido $userName a la pagina de peliculas!'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 1.5,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/movies');
                    },
                    icon: Icon(Icons.movie),
                    label: Text('Peliculas'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/genres');
                    },
                    icon: Icon(Icons.category),
                    label: Text('Generos'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/trends');
                    },
                    icon: Icon(Icons.trending_up),
                    label: Text('Tendencias'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/year_search');
                    },
                    icon: Icon(Icons.search),
                    label: Text('Buscar por Año'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}