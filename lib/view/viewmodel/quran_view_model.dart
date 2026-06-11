import 'package:flutter/material.dart';
import '../model/quran_schedule_response.dart';
import '../repository/quran_repository.dart';

class QuranViewModel extends ChangeNotifier {
  final QuranRepository repository;

  QuranViewModel(this.repository);

  bool isLoading = false;
  List<Surah> surahList = [];
  String? error;

  Future<void> getAllSurah() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await repository.fetchAllSurah();
      surahList = result.data;
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
