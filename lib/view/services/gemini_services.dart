import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService(String apiKey)
    : _model = GenerativeModel(
        model: 'gemini-3-flash-preview',
        apiKey: apiKey,
        // Tambahkan konfigurasi systemInstruction di bawah ini:
        systemInstruction: Content.system(
          "Anda adalah asisten khusus untuk Muslim App. "
          "Anda hanya boleh menjawab pertanyaan seputar topik Islam, sejarah Islam, doa, dan ibadah. "
          "Jika pengguna bertanya di luar topik tersebut (seperti politik praktis, coding, atau hal umum lainnya), "
          "jawablah dengan sopan bahwa Anda hanya bisa membantu dalam hal agama Islam.",
        ),
      );

  Future<String> getResponse(String prompt) async {
    debugPrint("=== PROSES KIRIM KE GEMINI ===");
    debugPrint("Prompt Pengguna: $prompt");

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      debugPrint("Respons Sukses dari Gemini!");
      return response.text ??
          "Maaf, saya tidak bisa menjawab pertanyaan tersebut.";
    } catch (e) {
      debugPrint("Error Asli dari Gemini Server: $e");
      return "Terjadi kesalahan sistem: $e";
    }
  }
}
