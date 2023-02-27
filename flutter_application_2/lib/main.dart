import 'package:flutter/material.dart';

// import 'util.dart';
import 'exo1.dart' as exo1;
import 'exo2.dart' as exo2;
import 'exo4.dart' as exo4;
import 'exo5.dart' as exo5;
import 'exo5_b.dart' as exo5_b;
import 'exo5_c.dart' as exo5_c;
import 'exo6.dart' as exo6;
import 'exo7.dart' as exo7;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MenuPage());
  }
}

class Exo {
  final String title;
  final String subtitle;
  final WidgetBuilder buildFunc;

  const Exo(
      {required this.title, required this.subtitle, required this.buildFunc});
}

List exos = [
  Exo(
      title: 'Exercice 1',
      subtitle: 'Simple image',
      buildFunc: (context) => exo1.DisplayImageWidget()),
  Exo(
      title: 'Exercice 2',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo2.ImageTransformationWidget()),
  Exo(
      title: 'Exercice 4',
      subtitle: 'Tuile',
      buildFunc: (context) => exo4.DisplayTileWidget()),
  Exo(
      title: 'Exercice 5',
      subtitle: 'Plateau de tuiles',
      buildFunc: (context) => exo5.TuilesViewWidget()),
  Exo(
      title: 'Exercice 5b',
      subtitle: 'Plateau de tuiles avec images',
      buildFunc: (context) => exo5_b.ImagesTuilesViewWidget()),
  Exo(
      title: 'Exercice 5c',
      subtitle: 'Plateau de tuiles avec images resizable',
      buildFunc: (context) => exo5_c.ResizableImagesTuilesViewWidget()),
  Exo(
      title: 'Exercice 6',
      subtitle: 'Animation tuies',
      buildFunc: (context) => exo6.PositionedTilesWidget()),
  Exo(
      title: 'Exercice 7',
      subtitle: 'Jeu de Taquin',
      buildFunc: (context) => exo7.TaquinWidget()),
];

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TP2'),
        ),
        body: ListView.builder(
            itemCount: exos.length,
            itemBuilder: (context, index) {
              var exo = exos[index];
              return Card(
                  child: ListTile(
                      title: Text(exo.title),
                      subtitle: Text(exo.subtitle),
                      trailing: Icon(Icons.play_arrow_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: exo.buildFunc),
                        );
                      }));
            }));
  }
}
