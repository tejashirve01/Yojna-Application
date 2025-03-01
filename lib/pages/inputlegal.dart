import"package:flutter/material.dart";
import 'package:Fixed_wages/pages/legalai.dart';
import 'package:flutter/material.dart';
import 'package:Fixed_wages/pages/legalai.dart';
import 'package:audioplayers/audioplayers.dart';



class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late AudioPlayer audioPlayer;
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playAudio(); // Play audio when the screen is opened
  }

  void playAudio() async {
    // Replace 'https://dl.sndup.net/qtmc/yojna.mp3' with the actual URL of your text-to-speech audio file
    await audioPlayer.play(UrlSource('https://dl.sndup.net/g6fr/Texttospeechfixedwages.mp3'));
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
        title: Text('Input Page'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _destinationController.text = 'Safety Concerns';
                  stopAudio(); // Stop audio when the button is pressed
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  primary: Colors.white,
                ),
                child: Text('1. Safety Concerns', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _destinationController.text = 'Contractual Rights';
                  stopAudio(); // Stop audio when the button is pressed
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  primary: Colors.white,
                ),
                child: Text('2. Contractual Rights', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _destinationController.text = 'Social Security';
                  stopAudio(); // Stop audio when the button is pressed
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  primary: Colors.white,
                ),
                child: Text('3. Social Security', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _destinationController.text = 'Wages and Benefits';
                  stopAudio(); // Stop audio when the button is pressed
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  primary: Colors.white,
                ),
                child: Text('4. Wages and Benefits', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _destinationController.text = 'Working Hours';
                  stopAudio(); // Stop audio when the button is pressed
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  primary: Colors.white,
                ),
                child: Text('5. Working Hours', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'ISSUE FACED[safety/contract/social security/wages/working hours, etc.]',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String cost = _costController.text;
                  String destination = _destinationController.text;
                  String source = _sourceController.text;
                  stopAudio(); // Stop audio when the "Legal Advice" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryPage(
                        cost: cost,
                        destination: destination,
                        source: source,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  primary: Colors.green[700],
                ),
                child: Text('Legal Advice', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
