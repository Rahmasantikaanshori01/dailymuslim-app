import 'package:flutter/material.dart';
import '../viewmodel/home_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../view/page/kalender.dart';
import '../view/page/profile.dart';
import '../view/page/al-quran.dart';
import '../view/page/bookmark.dart';
import '../view/page/doa.dart';
import '../view/page/kiblat.dart';
import 'page/tasbih_page.dart';
import '../view/page/shalat_page.dart';
import '../view/page/semua_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = HomeViewModel();
    vm.startAutoSlide();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: vm,
      builder: (_, __) {
        return Scaffold(
          drawer: _buildDrawer(),
          body: Stack(
            children: [
              SizedBox(
                height: 490,
                width: double.infinity,
                child: Image.asset(
                  'assets/masjid3.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 20),
                      _buildInfoCard(),
                      const SizedBox(height: 20),
                      _buildSearch(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 350,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.25),
                        Colors.white,
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 5, bottom: 120),
                    child: Column(
                      children: [
                        _buildMenuGrid(),
                        const SizedBox(height: 0), // jarak antara menu grid dan kalender
                        _buildCalendar(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= TOP BAR =================
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Assalamu'alaikum",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    vm.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              /// 🔥 AVATAR BISA DIKLIK
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilePage(vm: vm)),
                  );
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  backgroundImage: vm.profileImage != null
                      ? FileImage(vm.profileImage!)
                      : null,
                  child: vm.profileImage == null
                      ? const Icon(Icons.person)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= INFO CARD =================
  Widget _buildInfoCard() {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: vm.infoController,
        itemCount: vm.infoList.length,
        itemBuilder: (_, index) {
          final item = vm.infoList[index];

          // Path gambar untuk tiap item
          final imagePath = item['image'] ?? 'assets/default.png';

          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.8),
                  const Color(0xFF80B4DE).withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                // Teks di kiri
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title']!.replaceAll(' ', '\n'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5180A5),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['desc']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2C4A6B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Gambar besar di kanan tanpa lingkaran
                Image.asset(
                  imagePath,
                  width: 140, // atur sesuai keinginan
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearch() => Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(30),
    ),
    child: const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        border: InputBorder.none,
      ),
    ),
  );

  Widget _buildMenuGrid() {
    final menus = [
      {
        "icon": Icons.fingerprint,
        "label": "Tasbih",
        "page": const TasbihPage(),
      },
      {"icon": Icons.menu_book, "label": "Al-Quran", "page": const QuranPage()},
      {"icon": Icons.favorite, "label": "Doa", "page": const DoaPage()},
      {"icon": Icons.explore, "label": "Qiblat", "page": const QiblatPage()},
      // 🔥 BARIS KEDUA
      {
        "icon": Icons.calendar_month,
        "label": "Kalender",
        "page": const KalenderHijriahPage(),
      },
      {
        "icon": Icons.access_time,
        "label": "Sholat",
        "page": const ShalatPage(),
      },
      {
        "icon": Icons.bookmark,
        "label": "Bookmark",
        "page": const BookmarkPage(),
      },
      {
        "icon": Icons.apps,
        "label": "Semua",
        "page": const AllMenuPage(), // 👈 menu semua fitur
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menus.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9, // 🔥 biar tidak overflow
        ),
        itemBuilder: (context, index) {
          final item = menus[index];

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item["page"] as Widget),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'] as IconData, size: 25),
                  const SizedBox(height: 10),
                  Text(
                    item['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
      // kalender
  Widget _buildCalendar() {
    final List<String> months = [
      "Muharram",
      "Safar",
      "Rabi'ul Awwal",
      "Rabi'ul Akhir",
      "Jumadal Ula",
      "Jumadal Akhirah",
      "Rajab",
      "Sya'ban",
      "Ramadhan",
      "Syawwal",
      "Dzulqa'dah",
      "Dzulhijjah",
    ];

    final List<String> days = [
      "Ahad",
      "Itsnain",
      "Tsulatsa",
      "Arbi’aa",
      "Khamis",
      "Jum’ah",
      "Sabti",
    ];

    final Map<int, List<dynamic>> hijriDataPerMonth = {};

    Future<void> _fetchHijriMonth(int monthIndex) async {
      try {
        final year = DateTime.now().year;
        final url =
            "https://api.aladhan.com/v1/gToHCalendar/${monthIndex + 1}/$year";
        final res = await http.get(Uri.parse(url));
        final data = json.decode(res.body);
        hijriDataPerMonth[monthIndex] = data["data"];
      } catch (e) {
        debugPrint("HIJRI ERROR: $e");
        hijriDataPerMonth[monthIndex] = [];
      }
    }

    final Map<String, String> hijriEvents = {
      "1-1": "Tahun Baru Hijriah",
      "10-1": "Asyura",
      "12-3": "Maulid Nabi",
      "27-7": "Isra Mi'raj",
      "1-10": "Idul Fitri",
      "10-12": "Idul Adha",
    };

    DateTime _parseGregorian(String date) {
      try {
        return DateFormat("dd-MM-yyyy").parse(date);
      } catch (e) {
        return DateTime.now();
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KalenderHijriahPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 300,
        decoration: BoxDecoration(
          color: const Color(0xff98A1BC),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: PageView.builder(
          itemCount: months.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: hijriDataPerMonth.containsKey(index)
                  ? Future.value(hijriDataPerMonth[index])
                  : _fetchHijriMonth(
                      index,
                    ).then((_) => hijriDataPerMonth[index]),
              builder: (context, snapshot) {
                final hijriDays = snapshot.data ?? [];
                final today = DateTime.now();

                if (hijriDays.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                final firstGregorian = _parseGregorian(
                  hijriDays[0]["gregorian"]["date"],
                );
                final startingWeekday = firstGregorian.weekday % 7;

                List<Widget> dateWidgets = [];
                for (int i = 0; i < startingWeekday; i++) {
                  dateWidgets.add(const SizedBox());
                }
                for (var day in hijriDays) {
                  final gDate = _parseGregorian(day["gregorian"]["date"]);
                  final hDay = day["hijri"]["day"];
                  final hMonth = day["hijri"]["month"]["number"];
                  final key = "$hDay-$hMonth";
                  final isEvent = hijriEvents.containsKey(key);
                  final isToday =
                      gDate.year == today.year &&
                      gDate.month == today.month &&
                      gDate.day == today.day;

                  dateWidgets.add(
                    Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isToday
                            ? Colors.orange
                            : isEvent
                            ? Colors.orange.withOpacity(0.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isEvent
                            ? Border.all(color: Colors.orange, width: 1)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        hDay,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: (isToday || isEvent)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kalender Hijriah",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF567791),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      months[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: days
                          .map(
                            (day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFBFDFF9),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 6),
                    // ❌ Ubah ini supaya bisa scroll
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 7,
                        children: dateWidgets,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Text("Menu"),
          ),
          ListTile(title: Text("Profil")),
          ListTile(title: Text("Pengaturan")),
          ListTile(title: Text("Keluar")),
        ],
      ),
    );
  }
}
