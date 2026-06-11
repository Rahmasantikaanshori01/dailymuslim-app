import 'package:flutter/material.dart';
import '../../viewmodel/home_view_model.dart';
import '../home_page.dart';
import '../page/menu.dart';
import '../page/setting.dart';
import '../page/notif.dart';
import '../page/ai_chat.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  late HomeViewModel vm;

  final List<Widget> _pages = const [
    NotifPage(),
    ChatScreen(),
    HomePage(),
    MenuPage(),
    SettingsPage(),
  ];

  final List<IconData> _icons = [
    Icons.notifications,
    Icons.chat,
    Icons.home,
    Icons.more_horiz,
    Icons.settings,
  ];

  final List<String> _labels = [
    "Notifikasi",
    "AI Chat",
    "Home",
    "Semua Menu",
    "Pengaturan",
  ];

  @override
  void initState() {
    super.initState();
    vm = HomeViewModel();
    vm.navIndex = 2; // Default ke Home
  }

  void _onItemTapped(int index) {
    setState(() {
      vm.changeNav(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Menghilangkan background putih di belakang navbar
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: vm.navIndex, children: _pages),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFFBFD4F5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = constraints.maxWidth / _icons.length;

          return Stack(
            clipBehavior: Clip.none, // Agar lingkaran bisa keluar dari navbar
            children: [
              /// 🔵 Lingkaran indikator yang berpindah dan NAIK ke atas
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left:
                    (vm.navIndex * itemWidth) +
                    (itemWidth / 2) -
                    27.5, // 27.5 = setengah dari 55
                top: -20, // Nilai negatif agar lingkaran naik ke atas navbar
                child: Container(
                  width: 60,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFBFD4F5),
                      width: 5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    _icons[vm.navIndex],
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),

              /// 🔹 Item Navbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_icons.length, (index) {
                  final bool isActive = vm.navIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(index),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Ikon dengan animasi naik
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            transform: Matrix4.translationValues(
                              0,
                              isActive ? -20 : 0,
                              0,
                            ),
                            child: Icon(
                              _icons[index],
                              size: 26,
                              color: isActive
                                  ? Colors.transparent
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _labels[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
