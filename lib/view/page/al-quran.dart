import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dailymuslim/view/viewmodel/quran_view_model.dart';
import 'surah_detail_page.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Memanggil data surah saat halaman pertama kali dibuka
    Future.microtask(
      () => context.read<QuranViewModel>().getAllSurah(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<QuranViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFE9EEF6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHighlightCard(),
            const SizedBox(height: 10),
            _buildTabs(),
            const SizedBox(height: 10),

            /// 🔹 LIST SURAH
            Expanded(
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : vm.error != null
                      ? Center(child: Text(vm.error!))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          itemCount: vm.surahList.length,
                          itemBuilder: (context, index) {
                            final surah = vm.surahList[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SurahDetailPage(
                                        nomor: surah.nomor),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8E97B5),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      surah.nomor.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            surah.namaLatin,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            surah.arti,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Tombol kembali
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),

          // Judul
          const Text(
            'Al-Quran',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8AA6D1),
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const Spacer(),

          // Ikon bookmark & search
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.bookmark_border,
                    color: Color(0xFF8AA6D1)),
                onPressed: () {},
              ),
              IconButton(
                icon:
                    const Icon(Icons.search, color: Color(0xFF8AA6D1)),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= HIGHLIGHT CARD =================
  Widget _buildHighlightCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF8E97B5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Teks
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Al-Baqarah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Al-Baqarah adalah surah terpanjang dalam Al-Quran. '
                  'Surah ini membahas berbagai tema termasuk hukum, moralitas, '
                  'keimanan, doa, amal, keluarga, dan keadilan sosial.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Gambar Al-Quran (pastikan tersedia di assets)
          Image.asset(
            'assets/alquran.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // ================= TABS =================
  Widget _buildTabs() {
    final tabs = ["Baca", "Belajar", "Progres Saya"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: List.generate(tabs.length, (index) {
              final isActive = selectedTab == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: isActive
                        ? BoxDecoration(
                            color: const Color(0xFF8E97B5),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          )
                        : null,
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : const Color(0xFF8E97B5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            color: const Color(0xFF8AA6D1),
          ),
        ],
      ),
    );
  }
}