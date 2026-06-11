class SurahDetailResponse {
  final bool status;
  final SurahDetail data;

  SurahDetailResponse({
    required this.status,
    required this.data,
  });

  factory SurahDetailResponse.fromJson(Map<String, dynamic> json) {
    return SurahDetailResponse(
      status: json['status'] ?? true,
      data: SurahDetail.fromJson(json['data']),
    );
  }
}

class SurahDetail {
  final String namaLatin;
  final List<Ayat> ayat;

  SurahDetail({
    required this.namaLatin,
    required this.ayat,
  });

  factory SurahDetail.fromJson(Map<String, dynamic> json) {
    return SurahDetail(
      namaLatin: json['namaLatin'],
      ayat: (json['ayat'] as List)
          .map((e) => Ayat.fromJson(e))
          .toList(),
    );
  }
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksIndonesia;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksIndonesia,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksIndonesia: json['teksIndonesia'],
    );
  }
}
