import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/quran_schedule_response.dart';
import '../model/surah_detail_response.dart';

class QuranRepository {
  /// 🔹 Mengambil seluruh daftar surah
  Future<QuranSurahResponse> fetchAllSurah() async {
    final response = await http.get(
      Uri.parse('https://equran.id/api/v2/surat'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return QuranSurahResponse.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat daftar surah');
    }
  }

  /// 🔹 Mengambil detail surah berdasarkan nomor
  Future<SurahDetailResponse> fetchSurahDetail(int nomor) async {
    final response = await http.get(
      Uri.parse('https://equran.id/api/v2/surat/$nomor'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return SurahDetailResponse.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat detail surah');
    }
  }
}