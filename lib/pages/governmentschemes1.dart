import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class governmentschemes1 extends StatefulWidget {
  const governmentschemes1({Key? key}) : super(key: key);

  @override
  State<governmentschemes1> createState() => _governmentschemes1State();
}

class _governmentschemes1State extends State<governmentschemes1> {
  late List<Map<String, String>> videos = [
    {'title': 'Jan dhan yojna', 'url': 'https://www.youtube.com/watch?v=Aqcm7mOIPLQ'},
    {'title': 'Labour card all yojnas', 'url': 'https://www.youtube.com/watch?v=8bF_EOrEIoc'},
    // Add more videos as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentations'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          String videoTitle = videos[index]['title']!;
          String videoUrl = videos[index]['url']!;

          // Create a separate YoutubePlayerController for each video
          YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
            flags: YoutubePlayerFlags(
              autoPlay: true, // Set this to true to start playing the video automatically
              mute: false,
            ),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  videoTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to full-screen view when video is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: Center(
                            child: YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text('Watch Video'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
