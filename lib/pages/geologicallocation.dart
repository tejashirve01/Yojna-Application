import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Location Widget Example')),
        body: LocationWidget(),
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      _locationData = await location.getLocation();
      print('Latitude: ${_locationData.latitude}, Longitude: ${_locationData.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Widget Example')),
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: _locationData != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${_locationData.latitude}',
              style: TextStyle(
                color: Colors.black, // Set text color to black
                fontSize: 16, // Set font size to 16
              ),
            ),
            Text(
              'Longitude: ${_locationData.longitude}',
              style: TextStyle(
                color: Colors.black, // Set text color to black
                fontSize: 16, // Set font size to 16
              ),
            ),
          ],
        )
            : _serviceEnabled != null && !_serviceEnabled
            ? Text(
          'Location services are disabled.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}

