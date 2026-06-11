// view/shalat_page.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/shalat_schedule_response.dart';
import '../viewmodel/shalat_view_model.dart';

class ShalatPage extends StatefulWidget {
  static const routeName = '/shalat';

  const ShalatPage({super.key});

  @override
  State<ShalatPage> createState() =>
      _ShalatPageState();
}

class _ShalatPageState
    extends State<ShalatPage> {
  late Timer timer;

  String currentTime = '';

  Map<String, bool> progress = {
    'Subuh': false,
    'Dzuhur': false,
    'Ashar': false,
    'Maghrib': false,
    'Isya': false,
  };

  @override
  void initState() {
    super.initState();

    _startClock();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      final now = DateTime.now();

      context
          .read<ShalatViewModel>()
          .fetchMonthlySchedule(
            cityId: 1206,
            year: now.year,
            month: now.month,
          );
    });
  }

  void _startClock() {
    currentTime = DateFormat(
      'HH:mm:ss',
    ).format(DateTime.now());

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          currentTime = DateFormat(
            'HH:mm:ss',
          ).format(DateTime.now());
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  ShalatDaySchedule? getTodayData(
    List<ShalatDaySchedule> schedules,
  ) {
    try {
      final now = DateTime.now();

      final today =
          now.day.toString().padLeft(
                2,
                '0',
              );

      return schedules.firstWhere(
        (e) {
          return e.tanggal
                  .split('-')
                  .last ==
              today;
        },
      );
    } catch (e) {
      if (schedules.isNotEmpty) {
        return schedules.first;
      }

      return null;
    }
  }

  bool isActivePrayer(
    String prayerTime,
  ) {
    try {
      final split =
          prayerTime.split(':');

      final prayerHour =
          int.parse(split[0]);

      final prayerMinute =
          int.parse(split[1]);

      final now =
          TimeOfDay.now();

      final nowMinutes =
          now.hour * 60 + now.minute;

      final prayerMinutes =
          prayerHour * 60 +
              prayerMinute;

      return nowMinutes >=
              prayerMinutes - 15 &&
          nowMinutes <=
              prayerMinutes + 30;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm =
        context.watch<
            ShalatViewModel>();

    final today =
        getTodayData(
      vm.schedules,
    );

    return Scaffold(
      backgroundColor:
          const Color(
              0xFFE9EEF6),
      body: vm.isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(
                color:
                    Colors.white,
              ),
            )
          : SafeArea(
              child:
                  SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                        20),
                child: Column(
                  children: [

                    // ================= HEADER =================

                    _buildHeader(
                        context),

                    const SizedBox(
                        height: 25),

                    // ================= JAM =================

                    Container(
                      width:
                          double.infinity,
                      padding:
                          const EdgeInsets
                              .all(30),
                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    35),
                        gradient:
                            const LinearGradient(
                          colors: [
                            Color(
                                0xFFAEB7D1),
                            Color(
                                0xFF98A3C5),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .black
                                .withOpacity(
                                    0.12),
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

                          const Text(
                            'WAKTU SEKARANG',
                            style:
                                TextStyle(
                              color: Colors
                                  .white70,
                              letterSpacing:
                                  2,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  15),

                          Text(
                            currentTime,
                            style:
                                const TextStyle(
                              color: Colors
                                  .white,
                              fontSize:
                                  48,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  8),

                          Text(
                            DateFormat(
                              'dd MMMM yyyy',
                            ).format(
                                DateTime
                                    .now()),
                            style:
                                const TextStyle(
                              color: Colors
                                  .white70,
                              fontSize:
                                  15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    // ================= SHOLAT =================

                    prayerCard(
                      'Subuh',
                      today?.subuh ??
                          '--:--',
                      Icons.dark_mode,
                    ),

                    prayerCard(
                      'Dzuhur',
                      today?.dzuhur ??
                          '--:--',
                      Icons.sunny,
                    ),

                    prayerCard(
                      'Ashar',
                      today?.ashar ??
                          '--:--',
                      Icons
                          .wb_sunny_outlined,
                    ),

                    prayerCard(
                      'Maghrib',
                      today?.maghrib ??
                          '--:--',
                      Icons
                          .nightlight_round,
                    ),

                    prayerCard(
                      'Isya',
                      today?.isya ??
                          '--:--',
                      Icons.bedtime,
                    ),

                    const SizedBox(
                        height: 30),

                    // ================= PROGRESS =================

                    Container(
                      width:
                          double.infinity,
                      padding:
                          const EdgeInsets
                              .all(24),
                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    30),
                        gradient:
                            const LinearGradient(
                          colors: [
                            Color(
                                0xFFAEB7D1),
                            Color(
                                0xFF98A3C5),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .black
                                .withOpacity(
                                    0.12),
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
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          const Text(
                            'Progress Saya',
                            style:
                                TextStyle(
                              color: Colors
                                  .white,
                              fontSize:
                                  24,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  20),

                          progressTile(
                              'Subuh'),
                          progressTile(
                              'Dzuhur'),
                          progressTile(
                              'Ashar'),
                          progressTile(
                              'Maghrib'),
                          progressTile(
                              'Isya'),

                          const SizedBox(
                              height:
                                  20),

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
                                  () {
                                setState(
                                    () {
                                  progress
                                      .updateAll(
                                    (
                                      key,
                                      value,
                                    ) =>
                                        false,
                                  );
                                });
                              },
                              child:
                                  const Text(
                                'Reset Progress',
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

                    const SizedBox(
                        height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(
      BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 10,
      ),
      child: Row(
        children: [

          /// BACK BUTTON

          Container(
            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(
                          0.15),
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

          /// TITLE

          const Text(
            'Sholat',
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

          const SizedBox(
              width: 48),
        ],
      ),
    );
  }

  // ================= SHOLAT CARD =================

  Widget prayerCard(
    String title,
    String time,
    IconData icon,
  ) {
    final active =
        isActivePrayer(time);

    return AnimatedContainer(
      duration:
          const Duration(
              milliseconds: 300),
      margin:
          const EdgeInsets.only(
              bottom: 16),
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: active
            ? Color(0xFF8E97B5)
            : Colors.white,
        borderRadius:
            BorderRadius.circular(
                28),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.08),
            blurRadius: 14,
            offset:
                const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [

          Container(
            height: 58,
            width: 58,
            decoration:
                BoxDecoration(
              color: active
                  ? Colors.white24
                  : const Color(
                      0xFF8E97B5),
              borderRadius:
                  BorderRadius
                      .circular(18),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: active
                        ? Colors.white
                        : const Color(
                            0xFF707B9E),
                    fontSize: 18,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(
                  active
                      ? 'Sedang berlangsung'
                      : 'Waktu Sholat',
                  style: TextStyle(
                    color: active
                        ? Colors.white70
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration:
                BoxDecoration(
              color: active
                  ? Colors.white24
                  : const Color(
                          0xFF8E97B5)
                      .withOpacity(
                          0.15),
              borderRadius:
                  BorderRadius
                      .circular(16),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: active
                    ? Colors.white
                    : const Color(
                        0xFF707B9E),
                fontWeight:
                    FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PROGRESS =================

  Widget progressTile(
      String prayer) {
    return CheckboxListTile(
      value: progress[prayer],
      activeColor: Colors.white,
      checkColor:
          const Color(
              0xFF8E97B5),
      title: Text(
        prayer,
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.w500,
        ),
      ),
      onChanged: (v) {
        setState(() {
          progress[prayer] =
              v ?? false;
        });
      },
    );
  }
}