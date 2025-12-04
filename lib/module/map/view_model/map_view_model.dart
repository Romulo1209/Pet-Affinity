import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobx/mobx.dart';

class MapViewModel {
  final Observable<Position?> currentPosition = Observable(null);
  final Observable<bool> isLoading = Observable(true);
  final Observable<String> selectedTheme = Observable('OpenStreetMap');

  final Map<String, Map<String, dynamic>> _mapThemes = {
    'OpenStreetMap': {
      'name': 'OpenStreetMap',
      'url': 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      'description': 'Mapa padrão com cores naturais',
      'icon': Icons.map,
      'color': Colors.green,
    },
    'CartoDB Light': {
      'name': 'CartoDB Light',
      'url': 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
      'description': 'Tema claro e minimalista',
      'icon': Icons.light_mode,
      'color': Colors.blue,
    },
    'CartoDB Dark': {
      'name': 'CartoDB Dark',
      'url': 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
      'description': 'Tema escuro elegante',
      'icon': Icons.dark_mode,
      'color': Colors.purple,
    },
    'Stamen Terrain': {
      'name': 'Stamen Terrain',
      'url': 'https://stamen-tiles.a.ssl.fastly.net/terrain/{z}/{x}/{y}.png',
      'description': 'Mapa topográfico com relevo',
      'icon': Icons.terrain,
      'color': Colors.brown,
    },
    'OpenTopoMap': {
      'name': 'OpenTopoMap',
      'url': 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
      'description': 'Mapa topográfico detalhado',
      'icon': Icons.landscape,
      'color': Colors.orange,
    },
    'Esri World Imagery': {
      'name': 'Esri World Imagery',
      'url':
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
      'description': 'Imagens de satélite',
      'icon': Icons.satellite,
      'color': Colors.red,
    },
  };

  final List<Map<String, dynamic>> _petLocations = [
    {
      'id': '1',
      'name': 'Rex',
      'type': 'Cachorro',
      'lat': -23.5505,
      'lng': -46.6333,
      'description': 'Cachorro perdido na região',
    },
    {
      'id': '2',
      'name': 'Mia',
      'type': 'Gato',
      'lat': -23.5489,
      'lng': -46.6388,
      'description': 'Gato encontrado',
    },
    {
      'id': '3',
      'name': 'Buddy',
      'type': 'Cachorro',
      'lat': -23.5520,
      'lng': -46.6310,
      'description': 'Cachorro para adoção',
    },
    {
      'id': '4',
      'name': 'Luna',
      'type': 'Gato',
      'lat': -23.5470,
      'lng': -46.6350,
      'description': 'Gato perdido',
    },
  ];

  // Getters (static/constant-like structures can remain plain)
  Map<String, Map<String, dynamic>> get mapThemes => _mapThemes;
  List<Map<String, dynamic>> get petLocations => _petLocations;
  String get selectedTilesUrl => _mapThemes[selectedTheme.value]!['url'];

  Future<void> initialize() async {
    await _checkPermissions();
    await _getCurrentLocation();
    runInAction(() {
      isLoading.value = false;
    });
  }

  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      return;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      runInAction(() {
        currentPosition.value = position;
      });
    } catch (_) {
      runInAction(() {
        currentPosition.value = Position(
          latitude: -23.5505,
          longitude: -46.6333,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      });
    }
  }

  void setSelectedTheme(String themeKey) {
    runInAction(() {
      if (_mapThemes.containsKey(themeKey)) {
        selectedTheme.value = themeKey;
      }
    });
  }

  // Helpers for UI colors based on theme
  Color getMarkerColor(String petType) {
    if (selectedTheme.value == 'CartoDB Dark') {
      return petType == 'Cachorro' ? Colors.blue[400]! : Colors.orange[400]!;
    } else if (selectedTheme.value == 'Esri World Imagery') {
      return petType == 'Cachorro' ? Colors.cyan : Colors.yellow[700]!;
    } else {
      return petType == 'Cachorro' ? Colors.blue : Colors.orange;
    }
  }

  Color getLabelTextColor() {
    if (selectedTheme.value == 'CartoDB Dark' ||
        selectedTheme.value == 'Esri World Imagery') {
      return Colors.white;
    }
    return Colors.black87;
  }

  Color getLabelBackgroundColor() {
    if (selectedTheme.value == 'CartoDB Dark') {
      return Colors.grey[800]!;
    }
    return Colors.white;
  }
}
