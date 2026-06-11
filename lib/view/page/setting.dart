import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Text(
          "Halaman Setting",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


// // ===========================
// // view/settings_page.dart
// // ===========================

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:dailymuslim/view/theme/theme_provider.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider =
//         Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       backgroundColor:
//           Theme.of(context)
//               .scaffoldBackgroundColor,

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding:
//               const EdgeInsets.all(20),

//           child: Column(
//             children: [

//               // ================= HEADER =================

//               _buildHeader(context),

//               const SizedBox(height: 25),

//               // ================= ACCOUNT =================

//               buildCard(
//                 child: Column(
//                   children: [

//                     const CircleAvatar(
//                       radius: 45,
//                       backgroundColor:
//                           Colors.white,
//                       child: Icon(
//                         Icons.person,
//                         size: 50,
//                         color:
//                             Color(0xFF8E97B5),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     const Text(
//                       'Muslim User',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight:
//                             FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     const Text(
//                       'Daily Muslim App',
//                       style: TextStyle(
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ================= THEME =================

//               buildCard(
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment
//                           .start,
//                   children: [

//                     const Text(
//                       'Tema Aplikasi',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight:
//                             FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     Wrap(
//                       spacing: 12,
//                       runSpacing: 12,
//                       children: [

//                         themeButton(
//                           context,
//                           'Default',
//                           const Color(
//                               0xFF8E97B5),
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'default');
//                           },
//                         ),

//                         themeButton(
//                           context,
//                           'Dark',
//                           Colors.black,
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'dark');
//                           },
//                         ),

//                         themeButton(
//                           context,
//                           'Light',
//                           Colors.white,
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'light');
//                           },
//                         ),

//                         themeButton(
//                           context,
//                           'Hijau',
//                           Colors.green,
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'green');
//                           },
//                         ),

//                         themeButton(
//                           context,
//                           'Ungu',
//                           Colors.purple,
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'purple');
//                           },
//                         ),

//                         themeButton(
//                           context,
//                           'Kuning',
//                           Colors.amber,
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'yellow');
//                           },
//                         ),

//                         themeButton(
//                           context,
//                           'Pink',
//                           Colors.pink,
//                           () {
//                             themeProvider
//                                 .changeTheme(
//                                     'pink');
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ================= SETTING =================

//               buildCard(
//                 child: Column(
//                   children: [

//                     settingTile(
//                       Icons.notifications,
//                       'Notifikasi',
//                     ),

//                     settingTile(
//                       Icons.volume_up,
//                       'Suara Adzan',
//                     ),

//                     settingTile(
//                       Icons.language,
//                       'Bahasa',
//                     ),

//                     settingTile(
//                       Icons.lock,
//                       'Privasi',
//                     ),

//                     settingTile(
//                       Icons.info,
//                       'Tentang Aplikasi',
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ================= BUTTON =================

//               SizedBox(
//                 width: double.infinity,

//                 child: ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(
//                     backgroundColor:
//                         Colors.white,

//                     foregroundColor:
//                         const Color(
//                             0xFF8E97B5),

//                     padding:
//                         const EdgeInsets
//                             .symmetric(
//                       vertical: 16,
//                     ),

//                     shape:
//                         RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius
//                               .circular(20),
//                     ),
//                   ),

//                   onPressed: () {},

//                   child: const Text(
//                     'Simpan Pengaturan',
//                     style: TextStyle(
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= HEADER =================

//   Widget _buildHeader(
//     BuildContext context,
//   ) {
//     return Row(
//       children: [

//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black
//                     .withOpacity(0.15),
//                 blurRadius: 6,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),

//           child: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//             ),

//             onPressed: () =>
//                 Navigator.pop(context),
//           ),
//         ),

//         const Spacer(),

//         const Text(
//           'Pengaturan',
//           style: TextStyle(
//             fontSize: 26,
//             fontWeight:
//                 FontWeight.bold,
//             color: Color(0xFF8AA6D1),
//             shadows: [
//               Shadow(
//                 color: Colors.black26,
//                 offset: Offset(0, 3),
//                 blurRadius: 4,
//               ),
//             ],
//           ),
//         ),

//         const Spacer(),

//         const SizedBox(width: 48),
//       ],
//     );
//   }

//   // ================= CARD =================

//   Widget buildCard({
//     required Widget child,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(22),

//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xFFAEB7D1),
//             Color(0xFF98A3C5),
//           ],
//         ),

//         borderRadius:
//             BorderRadius.circular(30),

//         boxShadow: [
//           BoxShadow(
//             color:
//                 Colors.black.withOpacity(0.1),
//             blurRadius: 14,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),

//       child: child,
//     );
//   }

//   // ================= THEME BUTTON =================

//   Widget themeButton(
//     BuildContext context,
//     String title,
//     Color color,
//     VoidCallback onTap,
//   ) {
//     return GestureDetector(
//       onTap: onTap,

//       child: Column(
//         children: [

//           Container(
//             height: 55,
//             width: 55,

//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white,
//                 width: 3,
//               ),
//             ),
//           ),

//           const SizedBox(height: 6),

//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= TILE =================

//   Widget settingTile(
//     IconData icon,
//     String title,
//   ) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,

//       leading: Container(
//         height: 45,
//         width: 45,

//         decoration: BoxDecoration(
//           color: Colors.white24,
//           borderRadius:
//               BorderRadius.circular(14),
//         ),

//         child: Icon(
//           icon,
//           color: Colors.white,
//         ),
//       ),

//       title: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//         ),
//       ),

//       trailing: const Icon(
//         Icons.arrow_forward_ios,
//         color: Colors.white70,
//         size: 16,
//       ),
//     );
//   }
// }