import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:dailymuslim/view/viewmodel/surah_detail_view_model.dart';
import 'package:dailymuslim/view/repository/quran_repository.dart';

class SurahDetailPage extends StatefulWidget {
  final int nomor;

  const SurahDetailPage({super.key, required this.nomor});

  @override
  State<SurahDetailPage> createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  late AudioPlayer _audioPlayer;
  int _repeatCount = 1;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    Future.microtask(() {
      context.read<SurahDetailViewModel>().loadSurah(widget.nomor);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// ▶️ Memutar audio ayat
  Future<void> _playAudio(String url) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(url));
    setState(() => _isPlaying = true);

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() => _isPlaying = false);
    });
  }

  /// 🔁 Mengubah jumlah pengulangan (1x - 5x)
  void _changeRepeat() {
    setState(() {
      _repeatCount = _repeatCount >= 5 ? 1 : _repeatCount + 1;
    });
  }

  /// ⬅️➡️ Navigasi antar surah
  void _navigateSurah(int nomor) {
    if (nomor < 1 || nomor > 114) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SurahDetailPage(nomor: nomor),
      ),
    );
  }

  /// ⬆️ Bottom Sheet Menu
  void _showBottomMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF8E97B5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.keyboard_arrow_up,
                  color: Colors.white, size: 30),
              const SizedBox(height: 20),
              _buildMenuItem(Icons.play_arrow, "Putar"),
              _buildMenuItem(Icons.check_circle_outline, "Baca"),
              _buildMenuItem(Icons.bookmark_border, "Penanda Halaman"),
              _buildMenuItem(Icons.edit, "Tambahkan catatan"),
              _buildMenuItem(Icons.lightbulb_outline, "Belajar"),
              _buildMenuItem(Icons.psychology_outlined, "Menghafalkan"),
              _buildMenuItem(Icons.share, "Bagikan"),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SurahDetailViewModel(QuranRepository())..loadSurah(widget.nomor),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9EEF6),
        body: SafeArea(
          child: Consumer<SurahDetailViewModel>(
            builder: (context, vm, _) {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.surah == null) {
                return const Center(child: Text("Data tidak ditemukan"));
              }

              final surah = vm.surah!;
              final ayatList = surah.ayat;

              return Column(
                children: [
                  /// ================= HEADER =================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// 🔙 Tombol Kembali (Kiri)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildCircleButton(
                            icon: Icons.arrow_back_ios_new,
                            onTap: () => Navigator.pop(context),
                          ),
                        ),

                        /// 📖 Nama Surah (Tengah)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8E97B5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    _navigateSurah(surah.nomor - 1),
                                child: const Icon(Icons.chevron_left,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                surah.namaLatin,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () =>
                                    _navigateSurah(surah.nomor + 1),
                                child: const Icon(Icons.chevron_right,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),

                        /// 🔖 Ikon Bookmark & Search (Kanan)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.bookmark_border,
                                    color: Color(0xFF8E97B5)),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.search,
                                    color: Color(0xFF8E97B5)),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔽 Tombol Bottom Sheet
                  GestureDetector(
                    onTap: _showBottomMenu,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF8E97B5),
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// ================= LIST AYAT =================
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: ayatList.length,
                      itemBuilder: (context, index) {
                        final ayat = ayatList[index];

                        final audioUrl =
                            "https://equran.nos.wjv-1.neo.id/audio-partial/"
                            "Misyari-Rasyid-Alafasy/"
                            "${surah.nomor.toString().padLeft(3, '0')}"
                            "${ayat.nomorAyat.toString().padLeft(3, '0')}.mp3";

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8E97B5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /// Nomor Ayat
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  ayat.nomorAyat.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),

                              /// Teks Arab
                              Text(
                                ayat.teksArab,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  height: 2,
                                ),
                              ),
                              const SizedBox(height: 10),

                              /// Latin
                              Text(
                                ayat.teksLatin,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),

                              /// Terjemahan
                              Text(
                                ayat.teksIndonesia,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),

                              const Divider(color: Colors.white54),

                              /// 🎧 AUDIO CONTROL
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: _changeRepeat,
                                    child: Text(
                                      "${_repeatCount}x",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.skip_previous,
                                            color: Colors.white),
                                        onPressed: index > 0
                                            ? () => setState(() {})
                                            : null,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          _isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _playAudio(audioUrl),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.skip_next,
                                            color: Colors.white),
                                        onPressed: index <
                                                ayatList.length - 1
                                            ? () => setState(() {})
                                            : null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// 🔘 Tombol Lingkaran
  Widget _buildCircleButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
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
        icon: Icon(icon, color: const Color(0xFF8E97B5)),
        onPressed: onTap,
      ),
    );
  }
}