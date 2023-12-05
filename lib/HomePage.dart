import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _fontSize = 30.0; // Taille de police initiale
  double _baseFontSize = 30.0; // Taille de police de base
  double _currentScale = 1.0; // Échelle actuelle
  double _previousScale = 1.0; // Échelle précédente

  void _handleScale(ScaleUpdateDetails details) {
    setState(() {
      _currentScale = details.scale * _previousScale;
      double newFontSize = _baseFontSize * _currentScale;

      // Limiter la taille minimale et maximale du texte
      if (newFontSize >= 15.0 && newFontSize <= 60.0) {
        _fontSize =
            newFontSize; // Applique la nouvelle taille si elle est dans les limites
      }
    });
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      _previousScale = _currentScale; // Met à jour l'échelle précédente
    });
  }

  void _increaseNumber() {
    setState(() {
      numberOfTimesTapped++; // Incrémente le compteur de taps
    });
  }

  int numberOfTimesTapped = 0; // Initialise le compteur de taps

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _increaseNumber, // Méthode appelée lorsqu'on appuie sur l'écran
      onScaleStart: (details) {
        _previousScale =
            _currentScale; // Stocke l'échelle précédente au début du redimensionnement
      },
      onScaleUpdate:
          _handleScale, // Méthode appelée lors de la mise à l'échelle
      onScaleEnd:
          _handleScaleEnd, // Méthode appelée à la fin du redimensionnement

      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${numberOfTimesTapped.toString()} Tap', // Texte affichant le compteur de taps
                style: TextStyle(
                    fontSize:
                        _fontSize), // Taille de police mise à jour dynamiquement
              ),
            ],
          ),
        ),
      ),
    );
  }
}
