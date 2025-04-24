import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'gemini_text_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the API key from the JSON file in assets
  final jsonString = await rootBundle.loadString('assets/env.json');
  final jsonMap = jsonDecode(jsonString);
  final apiKey = jsonMap['GEMINI_API_KEY'];

  // Make sure the API key is not empty
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API Key is missing in the env.json file');
  }

  runApp(MyApp(apiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;

  const MyApp(this.apiKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Chat',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ChatPage(apiKey: apiKey),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String apiKey;

  const ChatPage({super.key, required this.apiKey});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late GeminiTextService _gemini;
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _gemini = GeminiTextService(widget.apiKey);
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    _controller.clear();

    try {
      final reply = await _gemini.analyzeText(text);
      setState(() {
        _messages.add({'sender': 'gemini', 'text': reply});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'gemini', 'text': 'Error: $e'});
      });
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['sender'] == 'user';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message['text'] ?? '',
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gemini AI Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: _messages.map(_buildMessage).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ask about meal plans, fitness goals...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.deepPurple,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
