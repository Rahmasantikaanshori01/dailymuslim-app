import 'dart:async';
import 'dart:io'; // ✅ tambahan
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final PageController infoController = PageController();

  int infoIndex = 0;
  int navIndex = 2;

  /// ✅ DIUBAH: hilangkan default nama
  String userName = "";

  /// ✅ TAMBAHAN: foto profile
  File? profileImage;

  final List<Map<String, String>> infoList = [
    {
      "title": "START TASBIH COUNTER",
      "desc": "Hitung dzikir harianmu dengan mudah",
      'image': 'assets/tasbih.png'
    },
    {
      "title": "AL-QURAN DIGITAL",
      "desc": "Baca Al-Quran kapan saja",
      'image': 'assets/alquran.png'
    },
    {
      "title": "DOA HARIAN",
      "desc": "Kumpulan doa sehari-hari",
      'image': 'assets/doa.png'
    },
  ];

  Timer? _timer;

  void startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (infoController.hasClients) {
        infoIndex = (infoIndex + 1) % infoList.length;
        infoController.animateToPage(
          infoIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void changeNav(int index) {
    navIndex = index;
    notifyListeners();
  }

  /// ✅ METHOD BARU: update profile
  void updateProfile(String name, File? image) {
    userName = name;
    profileImage = image;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    infoController.dispose();
    super.dispose();
  }
}