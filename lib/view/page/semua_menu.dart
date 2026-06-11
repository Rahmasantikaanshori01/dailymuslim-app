import 'package:flutter/material.dart';

// ================= IMPORT PAGE =================

import 'package:dailymuslim/view/page/tasbih_page.dart';
import 'package:dailymuslim/view/page/al-quran.dart';
import 'package:dailymuslim/view/page/doa.dart';
import 'package:dailymuslim/view/page/kiblat.dart';
import 'package:dailymuslim/view/page/kalender.dart';
import 'package:dailymuslim/view/page/shalat_page.dart';
import 'package:dailymuslim/view/page/bookmark.dart';
import 'package:dailymuslim/view/page/ai_chat.dart';

// ================= ALL MENU PAGE =================

class AllMenuPage extends StatelessWidget {
  const AllMenuPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menus = [

      // ================= MENU =================

      {
        "icon": Icons.fingerprint,
        "label": "Tasbih",
        "page": const TasbihPage(),
      },

      {
        "icon": Icons.menu_book,
        "label": "Al-Quran",
        "page": const QuranPage(),
      },

      {
        "icon": Icons.favorite,
        "label": "Doa",
        "page": const DoaPage(),
      },

      {
        "icon": Icons.explore,
        "label": "Qiblat",
        "page": const QiblatPage(),
      },

      {
        "icon": Icons.calendar_month,
        "label": "Kalender",
        "page":
            const KalenderHijriahPage(),
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
        "icon": Icons.smart_toy,
        "label": "Ai Chat",
        "page": const  ChatScreen(),
      },

      // ================= MENU TAMBAHAN =================

      {
        "icon": Icons.auto_awesome,
        "label": "Asmaul Husna",
        "page": const ComingSoonPage(
          title: "Asmaul Husna",
        ),
      },

      {
        "icon": Icons.video_collection,
        "label": "Konten Islami",
        "page": const ComingSoonPage(
          title: "Konten Islami",
        ),
      },

      {
        "icon": Icons.calculate,
        "label": "Kalkulator Zakat",
        "page": const ComingSoonPage(
          title: "Kalkulator Zakat",
        ),
      },

      {
        "icon": Icons.mosque,
        "label": "Masjid Terdekat",
        "page": const ComingSoonPage(
          title: "Masjid Terdekat",
        ),
      },

      {
        "icon": Icons.school,
        "label": "Hafalan",
        "page": const ComingSoonPage(
          title: "Hafalan",
        ),
      },

      {
        "icon": Icons.history_edu,
        "label": "Asbabun Nuzul",
        "page": const ComingSoonPage(
          title: "Asbabun Nuzul",
        ),
      },

      {
        "icon": Icons.library_books,
        "label": "Hadis Arbain",
        "page": const ComingSoonPage(
          title: "Hadis Arbain",
        ),
      },
    ];

    return Scaffold(
      backgroundColor:
          const Color(0xFF8E97B5),

      body: SafeArea(
        child: Column(
          children: [

            // ================= HEADER =================

            _buildHeader(context),

            const SizedBox(height: 20),

            // ================= TITLE =================

            const Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Align(
                alignment:
                    Alignment.centerLeft,
                child: Text(
                  'Semua Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ================= GRID MENU =================

            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(20),
                decoration:
                    const BoxDecoration(
                  color: Color(
                      0xFFE8ECF5),
                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        Radius.circular(
                            35),
                    topRight:
                        Radius.circular(
                            35),
                  ),
                ),

                child: GridView.builder(
                  itemCount: menus.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.9,
                  ),

                  itemBuilder:
                      (context, index) {
                    final item =
                        menus[index];

                    return InkWell(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  22),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                item["page"]
                                    as Widget,
                          ),
                        );
                      },

                      child: Container(
                        decoration:
                            BoxDecoration(
                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(
                                  0xFFAEB7D1),
                              Color(
                                  0xFF98A3C5),
                            ],
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      24),

                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .black
                                  .withOpacity(
                                      0.08),

                              blurRadius:
                                  10,

                              offset:
                                  const Offset(
                                      0,
                                      5),
                            ),
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [

                            // ICON

                            Container(
                              height: 55,
                              width: 55,

                              decoration:
                                  BoxDecoration(
                                color: Colors
                                    .white
                                    .withOpacity(
                                        0.2),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            18),
                              ),

                              child: Icon(
                                item['icon']
                                    as IconData,

                                color: Colors
                                    .white,

                                size: 30,
                              ),
                            ),

                            const SizedBox(
                                height: 14),

                            // LABEL

                            Padding(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal:
                                    6,
                              ),

                              child: Text(
                                item['label']
                                    as String,

                                textAlign:
                                    TextAlign
                                        .center,

                                style:
                                    const TextStyle(
                                  color: Colors
                                      .white,

                                  fontSize:
                                      13,

                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),

      child: Row(
        children: [

          // BACK BUTTON

          Container(
            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,

              color: Colors.white,

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.15),

                  blurRadius: 6,

                  offset:
                      const Offset(
                          0,
                          3),
                ),
              ],
            ),

            child: IconButton(
              icon: const Icon(
                Icons
                    .arrow_back_ios_new,
              ),

              onPressed: () =>
                  Navigator.pop(
                      context),
            ),
          ),

          const Spacer(),

          // TITLE

          const Text(
            'Menu',
            style: TextStyle(
              fontSize: 26,
              fontWeight:
                  FontWeight.bold,

              color:
                  Color(0xFF8AA6D1),

              shadows: [
                Shadow(
                  color:
                      Colors.black26,

                  offset:
                      Offset(0, 3),

                  blurRadius: 4,
                ),
              ],
            ),
          ),

          const Spacer(),

          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

// ================= COMING SOON PAGE =================

class ComingSoonPage
    extends StatelessWidget {
  final String title;

  const ComingSoonPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF8E97B5),

      body: SafeArea(
        child: Center(
          child: Container(
            margin:
                const EdgeInsets.all(
                    25),

            padding:
                const EdgeInsets.all(
                    30),

            decoration:
                BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  Color(0xFFAEB7D1),
                  Color(0xFF98A3C5),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(
                      35),
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                const Icon(
                  Icons.construction,
                  color: Colors.white,
                  size: 80,
                ),

                const SizedBox(
                    height: 20),

                Text(
                  title,
                  textAlign:
                      TextAlign.center,

                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 15),

                const Text(
                  'Fitur sedang dalam pengembangan',
                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    color:
                        Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}