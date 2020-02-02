import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {

    setState(() {
      _markers.clear();
      for (int i=0;i<2;i++) {
        final marker = Marker(
          markerId: MarkerId('aehser'),
          position: LatLng(26.8679438, 73.8183076),
          infoWindow: InfoWindow(title: 'Aesher'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
        ));
        _markers['a'] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Google Office Locations'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),
    ),
  );
}