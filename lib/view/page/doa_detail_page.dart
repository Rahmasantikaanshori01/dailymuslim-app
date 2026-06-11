import 'package:flutter/material.dart';
import '../model/doa_model.dart';

class DoaDetailPage extends StatelessWidget {
  final Doa doa;

  const DoaDetailPage({super.key, required this.doa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EEF6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHighlightCard(),
            const SizedBox(height: 16),
            _buildDoaContent(),
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
          /// 🔙 Tombol Kembali
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
              color: const Color(0xFF8E97B5),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),

          /// 📌 Judul Doa di Tengah
          Expanded(
            flex: 3,
            child: Text(
              doa.nama.isNotEmpty ? doa.nama : 'Detail Doa',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          /// 🔖 Ikon Bookmark & Share
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.bookmark_border,
                    color: Color(0xFF8AA6D1)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Doa disimpan ke bookmark'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share,
                    color: Color(0xFF8AA6D1)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur bagikan akan segera hadir'),
                    ),
                  );
                },
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          /// 🔹 Informasi Doa
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doa.nama.isNotEmpty ? doa.nama : '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  doa.tentang.isNotEmpty
                      ? doa.tentang
                      : 'Doa harian untuk memohon perlindungan dan keberkahan dari Allah SWT.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          /// 🔹 Ilustrasi (Opsional)
          Image.asset(
            'assets/doa.png',
            width: 90,
            height: 100,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // ================= KONTEN DOA =================
  Widget _buildDoaContent() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
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
        child: ListView(
          children: [
            /// 🕌 Teks Arab
            Text(
              doa.ar.isNotEmpty ? doa.ar : '-',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                height: 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            /// 🔤 Teks Latin
            Text(
              doa.tr.isNotEmpty ? doa.tr : '-',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),

            /// 🇮🇩 Terjemahan
            Text(
              doa.idn.isNotEmpty ? doa.idn : '-',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            /// 🏷️ Tags
            if (doa.tag.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: doa.tag.map((t) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      t,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}