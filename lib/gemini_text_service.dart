import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiTextService {
  final String apiKey; // Accept apiKey as a parameter
  final String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-pro:generateContent';

  GeminiTextService(this.apiKey);

  Future<String> analyzeText(String userInput) async {
    if (apiKey.isEmpty) {
      throw Exception('API Key is missing');
    }

    final response = await http.post(
      Uri.parse('$_apiUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": userInput}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final candidates = data['candidates'];
      if (candidates != null && candidates.isNotEmpty) {
        return candidates[0]['content']['parts'][0]['text'];
      } else {
        return 'No response from Gemini.';
      }
    } else {
      throw Exception('Failed: ${response.statusCode} ${response.body}');
    }
  }
}
