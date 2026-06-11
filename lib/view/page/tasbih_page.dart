import 'package:flutter/material.dart';

class TasbihPage extends StatefulWidget {
  static const routeName = '/tasbih';

  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() =>
      _TasbihPageState();
}

class _TasbihPageState
    extends State<TasbihPage> {
  int count = 0;

  String selectedDzikir =
      'Subhanallah';

  final List<String> dzikirList = [
    'Subhanallah',
    'Alhamdulillah',
    'La Ilaha Illallah',
    'Allahu Akbar',
    'Istighfar',
    'Dzikir Setelah Sholat',
  ];

  void tambahTasbih() {
    setState(() {
      count++;
    });
  }

  void resetTasbih() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFE9EEF6),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            children: [

              // ================= HEADER =================

              _buildHeader(context),

              const SizedBox(height: 25),

              // ================= PILIH DZIKIR =================

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFFAEB7D1),
                      Color(0xFF98A3C5),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(
                          30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.12),
                      blurRadius: 18,
                      offset:
                          const Offset(
                              0,
                              10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    const Text(
                      'Pilih Dzikir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 16,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    18),
                      ),
                      child:
                          DropdownButtonHideUnderline(
                        child:
                            DropdownButton<
                                String>(
                          value:
                              selectedDzikir,
                          isExpanded: true,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      20),
                          items:
                              dzikirList.map((
                            e,
                          ) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  color: Color(
                                      0xFF707B9E),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (
                            value,
                          ) {
                            setState(() {
                              selectedDzikir =
                                  value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // ================= TASBIH =================

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(28),
                decoration: BoxDecoration(
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.12),
                      blurRadius: 18,
                      offset:
                          const Offset(
                              0,
                              10),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    Text(
                      selectedDzikir,
                      textAlign:
                          TextAlign.center,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // DISPLAY

                    Container(
                      width: 230,
                      padding:
                          const EdgeInsets
                              .all(20),
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .black
                                .withOpacity(
                                    0.15),
                            blurRadius:
                                18,
                            offset:
                                const Offset(
                                    0,
                                    10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [

                          // SCREEN

                          Container(
                            width: 150,
                            height: 80,
                            decoration:
                                BoxDecoration(
                              color: const Color(
                                  0xFFCFD4D0),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          18),
                              border:
                                  Border.all(
                                color: Colors
                                    .black54,
                                width: 4,
                              ),
                            ),
                            alignment:
                                Alignment
                                    .centerRight,
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal:
                                  18,
                            ),
                            child: Text(
                              count
                                  .toString(),
                              style:
                                  const TextStyle(
                                fontSize: 48,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color: Colors
                                    .black,
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 30),

                          // BUTTON +

                          GestureDetector(
                            onTap:
                                tambahTasbih,
                            child:
                                Container(
                              width: 95,
                              height: 95,
                              decoration:
                                  BoxDecoration(
                                shape: BoxShape
                                    .circle,
                                gradient:
                                    const LinearGradient(
                                  colors: [
                                    Color(
                                        0xFFAEB7D1),
                                    Color(
                                        0xFF8E97B5),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                            0.15),
                                    blurRadius:
                                        12,
                                    offset:
                                        const Offset(
                                            0,
                                            6),
                                  ),
                                ],
                              ),
                              child:
                                  const Icon(
                                Icons.touch_app,
                                color: Colors
                                    .white,
                                size: 45,
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 25),

                          // RESET

                          SizedBox(
                            width:
                                double.infinity,
                            child:
                                ElevatedButton(
                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    Colors
                                        .white,
                                foregroundColor:
                                    const Color(
                                        0xFF8E97B5),
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical:
                                      15,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              18),
                                ),
                              ),
                              onPressed:
                                  resetTasbih,
                              child:
                                  const Text(
                                'Reset Tasbih',
                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 10,
      ),
      child: Row(
        children: [

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
                      const Offset(0, 3),
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

          const Text(
            'Tasbih',
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