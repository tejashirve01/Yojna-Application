import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import 'package:Fixed_wages/ext.dart';
import 'package:flutter_tts/flutter_tts.dart';


class SummaryPage extends StatefulWidget {
  final String cost;
  final String destination;
  final String source;

  SummaryPage({required this.cost, required this.destination, required this.source});

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final OpenAI _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY, // Use your API key
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 20),
    ),
    enableLog: true,
  );

  FlutterTts flutterTts = FlutterTts();
  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();
    startConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Advisory'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('ISSUE FACED[safety/contract/social security/wages/working hours, etc.]: ${widget.source}'),
            Text('Where to help/file a complaint/contractual rights/safety issues: ${widget.destination}'),
            SizedBox(height: 20.0),
            Text('Legal Advisory:'),
            SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _messages.map((message) {
                    return Text(message.text);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startConversation() async {
    await addInitialMessages();
    await generateSummary();
  }

  Future<void> addInitialMessages() async {
    _messages.add(ChatMessage(
        user: ChatUser(id: '1', firstName: 'User', lastName: ''),
        createdAt: DateTime.now(),
        text: 'I am a labourer/sewageworker/worker in [Pune], India, facing issues related to ${widget.destination}.'
            'I need legal assistance to understand my rights and options.'
            'Can you provide information on the relevant labor laws and regulations in my industry?'
            'Guide me on this.'
    ));

    setState(() {});
  }

  Future<void> generateSummary() async {
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messages.map((message) {
        return Messages(
          role: Role.user,
          content: message.text,
        );
      }).toList(),
      maxToken: 200,
    );

    final response = await _openAI.onChatCompletion(request: request);

    setState(() {
      for (var element in response!.choices) {
        if (element.message != null) {
          _messages.add(
            ChatMessage(
              user: ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT'),
              createdAt: DateTime.now(),
              text: element.message!.content,
            ),
          );

          // Speak the response message
          speak(element.message!.content);
        }
      }
    });
  }

  void speak(String text) async {
    await flutterTts.speak(text);
  }
}
