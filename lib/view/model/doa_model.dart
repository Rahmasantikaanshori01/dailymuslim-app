class Doa {
  final int id;
  final String grup;
  final String nama;
  final String ar;
  final String tr;
  final String idn;
  final String tentang;
  final List<String> tag;

  Doa({
    required this.id,
    required this.grup,
    required this.nama,
    required this.ar,
    required this.tr,
    required this.idn,
    required this.tentang,
    required this.tag,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
      id: json['id'] ?? 0,
      grup: (json['grup'] ?? '').toString(),
      nama: (json['nama'] ?? '').toString(),
      ar: (json['ar'] ?? '').toString(),
      tr: (json['tr'] ?? '').toString(),
      idn: (json['idn'] ?? '').toString(),
      tentang: (json['tentang'] ?? '').toString(),
      tag: json['tag'] != null
          ? List<String>.from(json['tag'])
          : [],
    );
  }
}
