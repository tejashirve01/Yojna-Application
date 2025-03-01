import 'package:flutter/material.dart';

class JobSelectionPage extends StatelessWidget {
  final Function(String) onJobSelected;

  JobSelectionPage({required this.onJobSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                onJobSelected("chef");
              },
              child: Text('Chef'),
            ),
            ElevatedButton(
              onPressed: () {
                onJobSelected("sweeper");
              },
              child: Text('Sweeper'),
            ),
            ElevatedButton(
              onPressed: () {
                onJobSelected("cleaner");
              },
              child: Text('Cleaner'),
            ),
            ElevatedButton(
              onPressed: () {
                onJobSelected("carpenter");
              },
              child: Text('Carpenter'),
            ),
            ElevatedButton(
              onPressed: () {
                onJobSelected("plumber");
              },
              child: Text('Plumber'),
            ),
            // Add more job buttons as needed
          ],
        ),
      ),
    );
  }
}
