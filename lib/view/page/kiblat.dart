import 'package:flutter/material.dart';

class QiblatPage extends StatelessWidget {
  const QiblatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qiblat')),
      body: const Center(
        child: Text('Halaman Qiblat'),
      ),
    );
  }
}