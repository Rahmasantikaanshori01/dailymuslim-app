class QuranSurahResponse {
  final bool status;
  final List<Surah> data;

  QuranSurahResponse({
    required this.status,
    required this.data,
  });

  factory QuranSurahResponse.fromJson(Map<String, dynamic> json) {
    return QuranSurahResponse(
      status: json['status'] ?? true, // ← FIX
      data: (json['data'] as List)
          .map((e) => Surah.fromJson(e))
          .toList(),
    );
  }
}

class Surah {
  final int nomor;
  final String namaLatin;
  final String arti;
  final int jumlahAyat;

  Surah({
    required this.nomor,
    required this.namaLatin,
    required this.arti,
    required this.jumlahAyat,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: json['nomor'] ?? 0,
      namaLatin: json['namaLatin'] ?? '',
      arti: json['arti'] ?? '',
      jumlahAyat: json['jumlahAyat'] ?? 0,
    );
  }
}
