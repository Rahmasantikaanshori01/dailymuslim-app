import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class KalenderHijriahPage extends StatefulWidget {
  const KalenderHijriahPage({super.key});

  @override
  State<KalenderHijriahPage> createState() => _KalenderHijriahPageState();
}

class _KalenderHijriahPageState extends State<KalenderHijriahPage>
    with TickerProviderStateMixin {
  // ================= ANIMASI =================
  late final AnimationController _animController;
  late Animation<double> _fadeAnim;

  // ================= TANGGAL =================
  DateTime _focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime _now = DateTime.now();
  Timer? _timer;

  // ================= HIJRIAH STORAGE =================
  List<dynamic> _hijriDays = [];
  bool _isLoadingHijri = false;

  // ================= HARI BESAR =================
  final Map<String, String> _hijriEvents = {
    "1-1": "Tahun Baru Hijriah",
    "10-1": "Asyura",
    "12-3": "Maulid Nabi",
    "27-7": "Isra Mi'raj",
    "1-10": "Idul Fitri",
    "10-12": "Idul Adha",
  };

  // ================= NAMA BULAN HIJRIAH INDONESIA =================
  final Map<int, String> _bulanHijriahId = {
    1: "Muharram",
    2: "Safar",
    3: "Rabiul Awal",
    4: "Rabiul Akhir",
    5: "Jumadil Awal",
    6: "Jumadil Akhir",
    7: "Rajab",
    8: "Sya'ban",
    9: "Ramadhan",
    10: "Syawal",
    11: "Dzulqa'dah",
    12: "Dzulhijjah",
  };

  final List<String> _days = ["Ahad", "Its", "Tsu", "Arb", "Kha", "Jum", "Sab"];

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);

    _fetchHijriMonth(_focusedDay);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ================= PARSER TANGGAL =================
  DateTime _parseGregorian(String date) {
    try {
      return DateFormat("dd-MM-yyyy").parse(date);
    } catch (e) {
      debugPrint("PARSE ERROR: $date");
      return DateTime.now();
    }
  }

  // ================= FETCH HIJRIAH =================
  Future<void> _fetchHijriMonth(DateTime month) async {
    _isLoadingHijri = true;
    if (mounted) setState(() {});

    try {
      final url = "https://api.aladhan.com/v1/gToHCalendar/${month.month}/${month.year}";
      final res = await http.get(Uri.parse(url));
      final data = json.decode(res.body);

      _hijriDays = data["data"];
      _animController.forward(from: 0);
    } catch (e) {
      debugPrint("HIJRI ERROR: $e");
    }

    _isLoadingHijri = false;
    if (mounted) setState(() {});
  }

  // ================= NAVIGASI BULAN =================
  void _nextMonth() {
    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
    _fetchHijriMonth(_focusedDay);
  }

  void _prevMonth() {
    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
    _fetchHijriMonth(_focusedDay);
  }

  // ================= SWIPE =================
  void _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      _nextMonth();
    } else if (details.primaryVelocity! > 0) {
      _prevMonth();
    }
  }

  // ================= BUILD CALENDAR GRID =================
  List<Widget> _buildCalendarDays() {
    if (_hijriDays.isEmpty) return [];

    final firstGregorian = _parseGregorian(_hijriDays[0]["gregorian"]["date"]);
    int startingWeekday = firstGregorian.weekday % 7;

    List<Widget> widgets = [];
    final today = DateTime.now();

    for (int i = 0; i < startingWeekday; i++) {
      widgets.add(const SizedBox());
    }

    for (var day in _hijriDays) {
      final gDate = _parseGregorian(day["gregorian"]["date"]);
      final hDay = day["hijri"]["day"];
      final hMonth = day["hijri"]["month"]["number"];

      final key = "$hDay-$hMonth";
      final isEvent = _hijriEvents.containsKey(key);

      final isToday = gDate.year == today.year &&
          gDate.month == today.month &&
          gDate.day == today.day;

      widgets.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isToday
                ? Colors.orange
                : isEvent
                    ? Colors.orange.withOpacity(0.8)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isEvent ? Border.all(color: Colors.orange, width: 1) : null,
          ),
          child: Tooltip(
            message: isEvent ? _hijriEvents[key]! : "",
            child: Center(
              child: Text(
                hDay,
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.white,
                  fontWeight: (isToday || isEvent) ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  // ================= GET HIJRIAH MONTH NAME =================
  String _getHijriMonthName() {
    if (_hijriDays.isEmpty) return "";
    final h = _hijriDays[0]["hijri"];
    final m = int.parse(h["month"]["number"].toString());
    return "${_bulanHijriahId[m]} ${h["year"]} H";
  }

  // ================= FORMAT =================
  String get hari => DateFormat('EEEE', 'id_ID').format(_now);
  String get bulan => DateFormat('MMMM', 'id_ID').format(_now);
  String get tanggal => DateFormat('dd MMMM yyyy', 'id_ID').format(_now);
  String get waktu => DateFormat('HH:mm:ss').format(_now);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.70, // agar lebih naik
              decoration: const BoxDecoration(
                color: Color(0xFFDCE8F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _header(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _infoCard(),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _calendarCard(),
                        const SizedBox(height: 22),
                        _hariBesarList(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12), // agar lebih ke bawah
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Tombol back di kiri
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFBFD4F5).withOpacity(0.55),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              iconSize: 22,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        // Judul benar-benar di tengah
        const Center(
          child: Text(
            "Kalender",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9DB7E5),
              shadows: [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


  // ================= INFO CARD =================
  Widget _infoCard() {
  final double imageSize = 95; // Ukuran gambar matahari/bulan

  return Container(
    margin: const EdgeInsets.only(top: 30), // 👈 CARD TURUN KE BAWAH
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color.fromARGB(255, 155, 182, 232), Color.fromARGB(255, 91, 109, 149)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        // Ilustrasi dinamis (matahari/bulan)
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black38.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              _getTimeIllustrationImage(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Info teks
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoTextRow("Hari", hari),
              _divider(),
              _infoTextRow("Bulan", bulan),
              _divider(),
              _infoTextRow("Tanggal", tanggal),
              _divider(),
              _infoTextRow("Waktu", waktu),
            ],
          ),
        ),
      ],
    ),
  );
}

// Divider halus
Widget _divider() => Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      height: 1,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(2),
      ),
    );

// Teks info row dengan font Poppins
Widget _infoTextRow(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white70,
          fontSize: 13, // sedikit lebih kecil
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 15, // sedikit lebih kecil
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// Fungsi menentukan gambar matahari/bulan sesuai jam
String _getTimeIllustrationImage() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return "assets/sun.png"; // Pagi
  } else if (hour >= 12 && hour < 18) {
    return "assets/sun.png"; // Siang
  } else if (hour >= 18 && hour < 19) {
    return "assets/sunset.png"; // Matahari terbenam
  } else {
    return "assets/moon.png"; // Malam
  }
}

  // ================= CALENDAR =================
  Widget _calendarCard() {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDrag,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF8E9AB3),
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6))],
        ),
        child: _isLoadingHijri
            ? const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator(color: Colors.white)),
              )
            : FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    // Header bulan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: _prevMonth, icon: const Icon(Icons.chevron_left, color: Colors.white)),
                        Text(_getHijriMonthName(),
                            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        IconButton(onPressed: _nextMonth, icon: const Icon(Icons.chevron_right, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Nama hari
                    Row(
                        children: _days
                            .map((d) => Expanded(
                                  child: Center(
                                    child: Text(d,
                                        style: const TextStyle(
                                            color: Color(0xFFBFDFF9), fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ))
                            .toList()),
                    const SizedBox(height: 8),
                    // Grid tanggal
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 7,
                      children: _buildCalendarDays(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ================= LIST HARI BESAR =================
  Widget _hariBesarList() {
    if (_isLoadingHijri) return const SizedBox();

    final currentMonthEvents = <Map<String, String>>[];

    if (_hijriDays.isEmpty) return const SizedBox();

    final currentHijriMonth = int.parse(_hijriDays[0]["hijri"]["month"]["number"].toString());

    for (var day in _hijriDays) {
      final hDay = int.parse(day["hijri"]["day"].toString());
      final hMonth = int.parse(day["hijri"]["month"]["number"].toString());
      final key = "$hDay-$hMonth";

      if (_hijriEvents.containsKey(key)) {
        currentMonthEvents.add({
          "title": _hijriEvents[key]!,
          "date": DateFormat('dd MMM yyyy', 'id_ID').format(_parseGregorian(day["gregorian"]["date"])),
        });
      }
    }

    if (currentMonthEvents.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text("List Hari Besar",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF6B7FAF)))),
        const SizedBox(height: 14),
        ...currentMonthEvents.map((e) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xFF8E9AB3),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))]),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.star, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(e["title"]!,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  Text(e["date"]!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            )),
      ],
    );
  }
}
