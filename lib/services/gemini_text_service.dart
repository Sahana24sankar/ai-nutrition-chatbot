import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class GeminiTextService {
  final String apiKey;

  // API URLs
  final String _analyzeTextUrl =
      'https://generativelanguage.googleapis.com/v1beta2/models/gemini-2.0:generateMessage';
  final String _generateResponseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  GeminiTextService(this.apiKey);

  /// Analyze text using the existing API
  Future<String> analyzeText(String userInput) async {
    if (apiKey.isEmpty) {
      throw Exception('API Key is missing');
    }

    try {
      final response = await http.post(
        Uri.parse('$_analyzeTextUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "prompt": {
            "messages": [
              {"content": userInput},
            ],
          },
          "temperature": 0.7,
          "topK": 40,
          "topP": 0.95,
          "candidateCount": 1,
        }),
      );

      developer.log('AnalyzeText Request: $userInput');
      developer.log('AnalyzeText Response Status: ${response.statusCode}');
      developer.log('AnalyzeText Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          String responseText = candidates[0]['content'];
          responseText = _processBoldText(responseText);
          return responseText;
        } else {
          return 'No response from NutriZen-Bot.';
        }
      } else {
        throw Exception('Failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      developer.log('AnalyzeText Exception: $e');
      throw Exception('An error occurred while processing the request.');
    }
  }

  /// Generate response using the new API with language-specific prompts
  Future<String> generateResponse(String input, String languageCode) async {
    if (apiKey.isEmpty) {
      throw Exception('API Key is missing');
    }

    final prompt = _getLanguagePrompt(languageCode) + input;

    try {
      final response = await http.post(
        Uri.parse('$_generateResponseUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      developer.log('GenerateResponse Request: $prompt');
      developer.log('GenerateResponse Response Status: ${response.statusCode}');
      developer.log('GenerateResponse Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('Failed to generate response: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('GenerateResponse Exception: $e');
      throw Exception('Error generating response: $e');
    }
  }

  /// Helper function to remove ** and mark text for bold rendering
  String _processBoldText(String text) {
    final regex = RegExp(r'\*\*(.*?)\*\*'); // Matches text inside ** **
    return text.replaceAllMapped(
      regex,
      (match) => match[1]!,
    ); // Removes ** and keeps the text
  }

  /// Helper function to get the language-specific prompt
  String _getLanguagePrompt(String languageCode) {
    switch (languageCode) {
      case 'ta':
        return 'Respond in Tamil language. User question: ';
      default:
        return 'Respond in English. User question: ';
    }
  }
}
