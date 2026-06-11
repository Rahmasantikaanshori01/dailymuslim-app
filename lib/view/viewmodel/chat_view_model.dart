import 'package:flutter/material.dart';
import 'package:dailymuslim/view/model/chat_message_model.dart';
import 'package:dailymuslim/view/repository/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository repository;

  ChatViewModel(this.repository);

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(ChatMessage(text: text, isUser: true));
    _isLoading = true;
    notifyListeners();

    final response = await repository.sendMessage(text);

    _messages.add(ChatMessage(text: response, isUser: false));
    _isLoading = false;
    notifyListeners();
  }
}