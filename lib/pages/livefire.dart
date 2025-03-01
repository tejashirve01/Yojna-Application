import 'package:Fixed_wages/pages/start.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Fixed_wages/pages/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Database Example',
      home: NewApp(),
    );
  }
}

class NewApp extends StatefulWidget {
  @override
  _NewAppState createState() => _NewAppState();
}

class _NewAppState extends State<NewApp> {
  final databaseReference = FirebaseDatabase.instance.reference().child("JOBS");
  String path = ""; // Initializing path as empty string
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Location location = Location(); // Initialize location instance

  @override
  void initState() {
    super.initState();
    // Call getLocation() to retrieve device location and set it to the locationController
    getLocation();
  }

  void setPath(String newPath) {
    setState(() {
      path = newPath; // Updating the path
    });
  }

  Future<void> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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
      // Concatenate latitude and longitude as string
      String locationString = '${_locationData.latitude}, ${_locationData.longitude}';
      // Set the location data string to the locationController
      setState(() {
        locationController.text = locationString;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void sendDataToDatabase(String name, String phoneNo, String location) {
    if (path.isNotEmpty) {
      databaseReference.child(path).child(phoneNo).set({
        'name': name,
        'phone': phoneNo,
        'location': locationController.text,
        'job': path, // Storing the job name in the database
        'timestamp': DateTime.now().toString(),
      }).then((_) {
        print('Data sent successfully!');
        // Clearing the input fields after successful submission
        nameController.clear();
        phoneController.clear();
        locationController.clear();
        // Navigate to the start page after submitting data
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => start()),
        );
      }).catchError((error) {
        print('Failed to send data: $error');
      });
    } else {
      print('Path is empty!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
              ),
            ),
            SizedBox(height: 12),
            Text('Select a Job:'),
            SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: <Widget>[
                  jobButton("Chef", "assets/images/chef.png"),
                  jobButton("Sweeper", "assets/images/sweeper.jpeg"),
                  jobButton("Cleaner", "assets/images/cleaner.jpg"),
                  jobButton("Carpenter", "assets/images/carpenter.png"),
                  jobButton("Plumber", "assets/images/plumber.jpg"),
                  // Add more job buttons as needed
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getLocation(); // Retrieve location before sending data
                sendDataToDatabase(
                  nameController.text.trim(),
                  phoneController.text.trim(),
                  locationController.text.trim(),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                  color: Colors.blue, // Adjust the button color as needed
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Adjust the text color as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget jobButton(String jobTitle, String imagePath) {
    return ElevatedButton(
      onPressed: () {
        setPath(jobTitle.toLowerCase());
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
        ),
        padding: EdgeInsets.zero, // Remove padding
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
          color: Colors.white, // Adjust the box color as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Add padding to the entire button
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded( // Ensure the image takes up all available space
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Ensure the image covers the entire space
                ),
              ),
              SizedBox(height: 8),
              Text(jobTitle),
            ],
          ),
        ),
      ),
    );
  }
}
