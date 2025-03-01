import 'package:Fixed_wages/pages/governmentschemes.dart';

import 'package:Fixed_wages/pages/inputlegal.dart';
import 'package:flutter/material.dart';
import 'package:Fixed_wages/master.dart';
import 'package:Fixed_wages/pages/inputlegal.dart';
import 'package:Fixed_wages/pages/governmentschemes1.dart';

import 'package:audioplayers/audioplayers.dart';

class start extends StatefulWidget {
  const start({Key? key}) : super(key: key);

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playAudio(); // Play audio when the screen is opened
  }

  void playAudio() async {
    // Replace 'https://dl.sndup.net/qtmc/yojna.mp3' with the actual URL of your audio file
    await audioPlayer.play(UrlSource('https://dl.sndup.net/m825/ttslast.mp3'));
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Release resources when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5 options'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildOptionButton("Jobs", Icons.work, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  stopAudio();
                  return Master();
                }),
              );
            }),
            SizedBox(height: 20),
            buildOptionButton("Legal Help", Icons.assignment, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  stopAudio();
                  return InputPage();
                }),
              );
            }),
            SizedBox(height: 20),
            buildOptionButton("Government Schemes", Icons.account_balance, () {
              // Navigate to the government schemes screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  stopAudio();
                  return governmentschemes1();
                }),
              );
            }),
            SizedBox(height: 20),
            buildOptionButton("Skill Up", Icons.school, () {
              // Navigate to the skill up screen
              stopAudio();
            }),
            SizedBox(height: 20),
            buildOptionButton("Essential Documents", Icons.description, () {
              // Navigate to the documents tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  stopAudio();
                  // Add your logic here for the "Essential Documents" screen
                  return governmentschemes(); // Replace YourDocumentsScreen with the actual screen
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildOptionButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      height: 100,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
        label: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.blueGrey[50],
        ),
      ),
    );
  }
}
