import 'package:flutter/material.dart';
import 'package:dailymuslim/view/model/surah_detail_response.dart';
import 'package:dailymuslim/view/repository/quran_repository.dart';

class SurahDetailViewModel extends ChangeNotifier {
  final QuranRepository repository;

  SurahDetailViewModel(this.repository);

  bool isLoading = false;
  SurahDetail? surah;
  String? error;

  Future<void> loadSurah(int nomor) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await repository.fetchSurahDetail(nomor);
      surah = result.data; // ✅ Tidak akan error jika model sudah benar
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}