import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pet_affinity/module/map/view_model/map_view_model.dart';
import 'package:pet_affinity/data/core/di/service_locator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController? _mapController;
  final MapViewModel viewModel = getIt<MapViewModel>();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    viewModel.initialize();
  }

  void _showPetInfo(Map<String, dynamic> pet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.pets,
                color: pet['type'] == 'Cachorro' ? Colors.blue : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(pet['name']),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipo: ${pet['type']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Descrição: ${pet['description']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showThemeSelector(BuildContext context, MapViewModel vm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.palette, color: Colors.blue),
                  const SizedBox(width: 8),
                  const Text(
                    'Escolher Tema do Mapa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Selecione um estilo de mapa:',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: vm.mapThemes.length,
                  itemBuilder: (context, index) {
                    String themeKey = vm.mapThemes.keys.elementAt(index);
                    Map<String, dynamic> theme = vm.mapThemes[themeKey]!;
                    bool isSelected = vm.selectedTheme == themeKey;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: isSelected
                          ? theme['color'].withOpacity(0.1)
                          : null,
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme['color'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            theme['icon'],
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          theme['name'],
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? theme['color'] : null,
                          ),
                        ),
                        subtitle: Text(theme['description']),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: theme['color'])
                            : null,
                        onTap: () {
                          vm.setSelectedTheme(themeKey);
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<Marker> petMarkers = viewModel.petLocations.map((pet) {
          final Color markerColor = viewModel.getMarkerColor(pet['type']);
          final Color labelBg = viewModel.getLabelBackgroundColor();
          final Color labelText = viewModel.getLabelTextColor();

          return Marker(
            point: LatLng(pet['lat'], pet['lng']),
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => _showPetInfo(pet),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: markerColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.pets,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: labelBg,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      pet['name'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: labelText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.map, size: 24, color: Colors.blue),
                  const SizedBox(width: 8),
                  const Text(
                    'Mapa de Pets',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _showThemeSelector(context, viewModel),
                    icon: Icon(
                      Icons.palette,
                      color: viewModel
                          .mapThemes[viewModel.selectedTheme.value]!['color'],
                    ),
                    tooltip: 'Mudar tema do mapa',
                  ),
                ],
              ),
            ),
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    viewModel.currentPosition.value?.latitude ?? -23.5505,
                    viewModel.currentPosition.value?.longitude ?? -46.6333,
                  ),
                  initialZoom: 15.0,
                  minZoom: 5.0,
                  maxZoom: 18.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: viewModel.selectedTilesUrl,
                    userAgentPackageName: 'com.example.pet_affinity',
                    maxZoom: 19,
                  ),
                  MarkerLayer(markers: petMarkers),
                  if (viewModel.currentPosition.value != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            viewModel.currentPosition.value!.latitude,
                            viewModel.currentPosition.value!.longitude,
                          ),
                          width: 40,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pets, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Cachorros',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pets, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Gatos',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton.small(
                    onPressed: () {
                      if (viewModel.currentPosition.value != null) {
                        _mapController?.move(
                          LatLng(
                            viewModel.currentPosition.value!.latitude,
                            viewModel.currentPosition.value!.longitude,
                          ),
                          15.0,
                        );
                      }
                    },
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.my_location, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
