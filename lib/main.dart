import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
<<<<<<< HEAD
import 'dart:developer'; // Import for the log function
import 'services/gemini_text_service.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
=======
import 'gemini_text_service.dart';
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45

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
<<<<<<< HEAD
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.teal.shade700),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LaunchPage(apiKey: apiKey),
    );
  }
}

class LaunchPage extends StatelessWidget {
  final String apiKey;

  const LaunchPage({super.key, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Teal gradient background (original colors)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF004D40), // Dark teal
                  Color(0xFF00796B), // Medium teal
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with shadow effect
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/logo1.png', // Replace with your logo file
                    height: 150,
                  ),
                ),
                const SizedBox(height: 16),
                // App name with vibrant styling
                const Text(
                  'NutriZen-Bot',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Tagline with subtle animation
                const Text(
                  'Optimizing the Human Equation',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
                // Get Started button with modern design
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 40,
                    ),
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoPage(apiKey: apiKey),
                      ),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40), // Dark teal text
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
=======
        primarySwatch: Colors.deepPurple,
      ),
      home: ChatPage(apiKey: apiKey),
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45
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
<<<<<<< HEAD
  final ScrollController _scrollController = ScrollController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  late GeminiTextService _gemini;
  final List<Map<String, String>> _messages = [];
  final List<String> _queries = [
    "What are the best foods for weight loss?",
    "How can I improve my protein intake?",
    "What are some healthy snack options?",
    "Can you suggest a balanced meal plan?",
  ];
  bool _isTyping = false;
=======
  late GeminiTextService _gemini;
  final List<Map<String, String>> _messages = [];
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _speech = stt.SpeechToText();
    _gemini = GeminiTextService(widget.apiKey);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );

    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
            _controller.text = _spokenText; // Autofill the text field
          });
        },
      );
    } else {
      setState(() {
        _isListening = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone not available.")),
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _sendMessage(String text) async {
=======
    _gemini = GeminiTextService(widget.apiKey);
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
<<<<<<< HEAD
      _isTyping = true;
    });

    _controller.clear();
    scrollToBottom();
=======
    });

    _controller.clear();
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45

    try {
      final reply = await _gemini.analyzeText(text);
      setState(() {
        _messages.add({'sender': 'gemini', 'text': reply});
<<<<<<< HEAD
        _isTyping = false;
      });
      scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'gemini',
          'text': 'Error: Unable to fetch response. Please try again later.',
        });
        _isTyping = false;
      });
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['sender'] == 'user';
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUser) // Show AI emoji for AI messages
                const CircleAvatar(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  child: Text('🤖'),
                ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.teal.shade700 : Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: _processText(message['text'] ?? '', isUser),
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.teal.shade700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isUser) // Add buttons only for AI responses
          Padding(
            padding: const EdgeInsets.only(left: 60.0, top: 4.0),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _sendMessage("Yes, it helped!"); // Predefined response
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _sendMessage("No, I need help."); // Predefined response
                  },
                  child: const Text(
                    "No, I need help",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _sendMessage(
                      "Explain this further.",
                    ); // Predefined response
                  },
                  child: const Text(
                    "Explain",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Helper function to process text and apply bold styling
  List<TextSpan> _processText(String text, bool isUser) {
    final regex = RegExp(r'\*\*(.*?)\*\*'); // Matches text inside ** **
    final matches = regex.allMatches(text);
    final spans = <TextSpan>[];

    int lastMatchEnd = 0;
    for (final match in matches) {
      // Add normal text before the match
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        );
      }

      // Add bold text for the match
      spans.add(
        TextSpan(
          text: match[1], // Extract text inside ** **
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      lastMatchEnd = match.end;
    }

    // Add remaining normal text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      );
    }

    return spans;
  }

  Widget _buildQueryButton(String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _sendMessage(query); // Send the query when tapped
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.teal.shade300, // Brighter teal background
            borderRadius: BorderRadius.circular(12), // Rounded corners
            border: Border.all(
              color: Colors.teal.shade700, // Border color
              width: 1.5, // Border width
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Subtle shadow
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              query,
              style: const TextStyle(
                color: Colors.white, // Brighter text color
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
=======
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
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            // Add the smaller logo
            Image.asset(
              'assets/logo1.png', // Path to your logo file
              height: 30, // Adjust the size of the logo
            ),
            const SizedBox(width: 8), // Add spacing between logo and text
            // Add the bot name
            const Text(
              "NutriZen-Bot",
              style: TextStyle(
                fontSize: 20, // Adjust font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF004D40), // Dark teal
              Color(0xFF00796B), // Medium teal
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController, // Attach the ScrollController
                padding: const EdgeInsets.all(8),
                children: [
                  if (_messages.isEmpty)
                    Column(children: _queries.map(_buildQueryButton).toList()),
                  ..._messages.map(_buildMessage),
                  if (_isTyping)
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          child: Text('🤖'),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Lottie.asset(
                            'assets/walking.json', // Ensure this path is correct
                            repeat: true,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask me anything...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor:
                            Colors.white, // White background for the chat box
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ), // Rounded corners
                          borderSide: BorderSide.none, // No border
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Voice button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // White background for the button
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isListening
                            ? Icons.mic
                            : Icons.mic_none, // Dynamic icon
                        color: Colors.teal, // Teal icon color
                      ),
                      onPressed: () {
                        if (_isListening) {
                          _stopListening();
                        } else {
                          _startListening();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // White background for the button
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.teal, // Teal icon color
                      ),
                      onPressed: () {
                        _sendMessage(_controller.text.trim());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic newMethod() {
    return Lottie.asset(
      'assets/walking.json', // Ensure this path is correct
      repeat: true,
    );
  }
}

class InfoPage extends StatefulWidget {
  final String apiKey;

  const InfoPage({super.key, required this.apiKey});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final TextEditingController signUpUsernameController =
      TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  String? savedEmail; // Temporarily store the email for Sign In
  String? savedPassword; // Temporarily store the password for Sign In
  bool isEmailValid = true; // Track email validation status

  bool validateEmail(String email) {
    // Regular expression for validating email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Sign In and Log In
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Welcome", style: TextStyle(color: Colors.white)),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: "Sign Up"), Tab(text: "Log In")],
          ),
        ),
        body: TabBarView(
          children: [
            // Sign Up Tab
            _buildSignUpTab(),
            // Log In Tab
            _buildLogInTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpTab() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),
          // Username TextField
          TextField(
            controller: signUpUsernameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.teal),
              labelText: "Username",
              filled: true,
              fillColor: Colors.teal.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Email TextField
          TextField(
            controller: signUpEmailController,
            onChanged: (value) {
              setState(() {
                isEmailValid = validateEmail(value);
              });
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Colors.teal),
              labelText: "Email",
              filled: true,
              fillColor: Colors.teal.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              errorText:
                  isEmailValid ? null : "Invalid email. Enter a valid one.",
            ),
          ),
          const SizedBox(height: 16),
          // Password TextField
          TextField(
            controller: signUpPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Colors.teal),
              labelText: "Password",
              filled: true,
              fillColor: Colors.teal.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Confirm Password TextField
          TextField(
            controller: signUpConfirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Colors.teal),
              labelText: "Confirm Password",
              filled: true,
              fillColor: Colors.teal.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Sign Up Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
            ),
            onPressed: () {
              final email = signUpEmailController.text.trim();
              final password = signUpPasswordController.text.trim();
              final confirmPassword =
                  signUpConfirmPasswordController.text.trim();

              if (email.isEmpty ||
                  password.isEmpty ||
                  confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields.")),
                );
              } else if (!isEmailValid) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid email. Enter a valid one."),
                  ),
                );
              } else if (password != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Passwords do not match.")),
                );
              } else {
                setState(() {
                  savedEmail = email;
                  savedPassword = password;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account created successfully!"),
                  ),
                );
              }
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogInTab() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),
          // Email TextField
          TextField(
            controller: loginEmailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Colors.teal),
              labelText: "Email",
              filled: true,
              fillColor: Colors.teal.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Password TextField
          TextField(
            controller: loginPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Colors.teal),
              labelText: "Password",
              filled: true,
              fillColor: Colors.teal.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Log In Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
            ),
            onPressed: () {
              final email = loginEmailController.text.trim();
              final password = loginPasswordController.text.trim();

              if (email.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter both email and password."),
                  ),
                );
              } else if (email != savedEmail || password != savedPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid email or password.")),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(apiKey: widget.apiKey),
                  ),
                );
              }
            },
            child: const Text(
              "Log In",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
=======
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
>>>>>>> 1ece1723fc807739000f3771190c7af21b933c45
        ],
      ),
    );
  }
}
