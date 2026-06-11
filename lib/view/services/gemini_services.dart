import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService(String apiKey)
      : _model = GenerativeModel(
          model: 'gemini-3-flash-preview', // ✅ Model yang valid
          apiKey: apiKey,
        );

  Future<String> getResponse(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      return response.text ?? "Maaf, saya tidak bisa menjawab pertanyaan tersebut.";
    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }
}