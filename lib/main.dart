import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';

// ================= HALAMAN UTAMA =================

import 'package:dailymuslim/view/widget/main_nav_page.dart';

// ================= PAGE =================

import 'package:dailymuslim/view/page/tasbih_page.dart';

// ================= REPOSITORIES =================

import 'package:dailymuslim/view/repository/quran_repository.dart';

import 'package:dailymuslim/view/repository/doa_repository.dart';

import 'package:dailymuslim/view/repository/chat_repository.dart';

import 'package:dailymuslim/view/repository/shalat_repository.dart';

// ================= VIEW MODELS =================

import 'package:dailymuslim/view/viewmodel/quran_view_model.dart';

import 'package:dailymuslim/view/viewmodel/doa_view_model.dart';

import 'package:dailymuslim/view/viewmodel/surah_detail_view_model.dart';

import 'package:dailymuslim/view/viewmodel/chat_view_model.dart';

import 'package:dailymuslim/view/viewmodel/shalat_view_model.dart';

// ================= SERVICES =================

import 'package:dailymuslim/view/services/gemini_services.dart';

void main() async {

WidgetsFlutterBinding.ensureInitialized();

// ================= INIT LOCALE INDONESIA =================

await initializeDateFormatting(

'id_ID',

null,

);

runApp(

const MuslimApp(),

);

}

class MuslimApp extends StatelessWidget {

const MuslimApp({

super.key,

});

@override

Widget build(BuildContext context) {

return ScreenUtilInit(

  designSize: const Size(

    375,

    812,

  ),

  minTextAdapt: true,

  splitScreenMode: true,



  builder: (

    context,

    child,

  ) {

    return MultiProvider(

      providers: [



        // ================= SERVICES =================



        Provider<GeminiService>(

          create: (_) => GeminiService(

            'AIzaSyCralAltSEjTET-z2hqX1HGiUOd6mK3Nu4',

          ),

        ),



        // ================= REPOSITORIES =================



        Provider<QuranRepository>(

          create: (_) =>

              QuranRepository(),

        ),



        Provider<DoaRepository>(

          create: (_) =>

              DoaRepository(),

        ),



        Provider<ChatRepository>(

          create: (context) =>

              ChatRepository(

            context.read<

                GeminiService>(),

          ),

        ),



        Provider<ShalatRepository>(

          create: (_) =>

              ShalatRepository(),

        ),



        // ================= VIEW MODELS =================



        ChangeNotifierProvider<

            QuranViewModel>(

          create: (context) =>

              QuranViewModel(

            context.read<

                QuranRepository>(),

          ),

        ),



        ChangeNotifierProvider<

            DoaViewModel>(

          create: (context) =>

              DoaViewModel(

            context.read<

                DoaRepository>(),

          ),

        ),



        ChangeNotifierProvider<

            SurahDetailViewModel>(

          create: (context) =>

              SurahDetailViewModel(

            context.read<

                QuranRepository>(),

          ),

        ),



        ChangeNotifierProvider<

            ChatViewModel>(

          create: (context) =>

              ChatViewModel(

            context.read<

                ChatRepository>(),

          ),

        ),



        ChangeNotifierProvider<

            ShalatViewModel>(

          create: (context) =>

              ShalatViewModel(

            context.read<

                ShalatRepository>(),

          ),

        ),

      ],



      child: MaterialApp(

        debugShowCheckedModeBanner:

            false,



        locale: const Locale(

          'id',

          'ID',

        ),



        // ================= HOME =================



        home: const MainNavPage(),



        // ================= ROUTES =================



        routes: {



          // TASBIH PAGE

          TasbihPage.routeName:

              (_) =>

                  const TasbihPage(),

        },

      ),

    );

  },

);

}

}

