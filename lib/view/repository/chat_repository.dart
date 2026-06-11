import 'package:dailymuslim/view/services/gemini_services.dart';

class ChatRepository {
  final GeminiService service;

  ChatRepository(this.service);

  Future<String> sendMessage(String message) async {
    return await service.getResponse(message);
  }
}