class ShalatScheduleResponse {
  final bool status;
  final List<ShalatDaySchedule> schedules;

  ShalatScheduleResponse({required this.status, required this.schedules});

  factory ShalatScheduleResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    final jadwal = data['jadwal'] as List<dynamic>;

    return ShalatScheduleResponse(
      status: json['status'] == true,
      schedules: jadwal.map((e) => ShalatDaySchedule.fromJson(e)).toList(),
    );
  }
}

class ShalatDaySchedule {
  final String tanggal;
  final String subuh;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  ShalatDaySchedule({
    required this.tanggal,
    required this.subuh,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  factory ShalatDaySchedule.fromJson(Map<String, dynamic> json) {
    return ShalatDaySchedule(
      tanggal: json['tanggal'].toString(),

      subuh: json['subuh'].toString(),

      dzuhur: json['dzuhur'].toString(),

      ashar: json['ashar'].toString(),

      maghrib: json['maghrib'].toString(),

      isya: json['isya'].toString(),
    );
  }
}
