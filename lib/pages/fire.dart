import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class fire extends StatefulWidget {
  const fire({Key? key}) : super(key: key);

  @override
  State<fire> createState() => _fireState();
}

class _fireState extends State<fire> {
  CollectionReference collRef =
  FirebaseFirestore.instance.collection('client');
  late TextEditingController _emailController,
      _nameController,
      _phoneController,
      _jobController,
      _locationController;

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _jobController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    if (!_isListening) {
                      startListening(_emailController);
                    } else {
                      stopListening();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    if (!_isListening) {
                      startListening(_nameController);
                    } else {
                      stopListening();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    if (!_isListening) {
                      startListening(_phoneController);
                    } else {
                      stopListening();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(
                labelText: 'Job',
                prefixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    if (!_isListening) {
                      startListening(_jobController);
                    } else {
                      stopListening();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                prefixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    if (!_isListening) {
                      startListening(_locationController);
                    } else {
                      stopListening();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                addClient();
              },
              child: const Text('Add Client'),
            ),
            SizedBox(height: 20.0),
            StreamBuilder<QuerySnapshot>(
              stream: collRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final clients = snapshot.data?.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: clients?.length,
                    itemBuilder: (context, index) {
                      final client = clients![index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(client['name']),
                        subtitle: Text(client['email']),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void startListening(TextEditingController controller) {
    _speech.listen(
      onResult: (result) {
        setState(() {
          controller.text = result.recognizedWords;
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }

  void stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void addClient() {
    try {
      collRef.add({
        'email': _emailController.text,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'job': _jobController.text,
        'location': _locationController.text,
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _jobController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
