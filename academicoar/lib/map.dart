import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  GoogleMapController? _controller;
  static const LatLng _defaultLocation = LatLng(-1.656974, -78.6801592);
  static const double _defaultZoom = 15.0;

  String ciudad = 'Riobamba';
  double latitud = -1.656974;
  double longitud = -78.6801592;
  String estadoClima = '';
  String temperatura = '';
  String viento = '';
  bool isLoading = false;

  // Método para obtener datos del clima
  Future<void> obtenerClima() async {
    setState(() {
      isLoading = true;
    });

    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extraer los datos del clima
        setState(() {
          temperatura =
              data['current_weather']['temperature'].toString() + '°C';
          viento = data['current_weather']['windspeed'].toString() + ' km/h';

          isLoading = false;
        });
      } else {
        throw Exception('No se pudo obtener el clima');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error al obtener el clima: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerClima(); // Obtener el clima al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E6E7),
      appBar: AppBar(
        title: Center(
          child: Text('MAPA', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Color(0xFF49868C),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CLIMA ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {}, // Refrescar clima
                      ),
                    ],
                  ),
                  isLoading
                      ? CircularProgressIndicator() // Mostrar cargando mientras se obtiene el clima
                      : Column(
                        children: [
                          Text(
                            '$ciudad, $temperatura; Viento: $viento',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF49868C),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Riobamba',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            // Usar Expanded para que el mapa ocupe el espacio disponible
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: _defaultLocation,
                zoom: _defaultZoom,
              ),
              //minMaxZoomPreference: MinMaxZoomPreference(14.0, 21.0), yo no le habilité esto pq siento muy castroso el mapa
              mapType:
                  MapType.normal, // Puedes cambiar a Satellite, Terrain, etc.
              myLocationEnabled: true, // Habilita el botón de ubicación
              myLocationButtonEnabled: true, // Muestra el botón de ubicación
            ),
          ),
        ],
      ),
    );
  }
}
