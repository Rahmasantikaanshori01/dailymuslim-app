import 'package:flutter/material.dart';
import '../model/doa_model.dart';
import '../repository/doa_repository.dart';

class DoaViewModel extends ChangeNotifier {
  final DoaRepository repository;

  DoaViewModel(this.repository);

  List<Doa> doaList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchDoa() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      doaList = await repository.getAllDoa();

      debugPrint('Jumlah doa: ${doaList.length}');
      for (var d in doaList) {
        debugPrint('Nama: "${d.nama}"');
        debugPrint('Arab: "${d.ar}"');
        debugPrint('Latin: "${d.tr}"');
        debugPrint('Terjemahan: "${d.idn}"');
      }
    } catch (e) {
      errorMessage = e.toString();
      doaList = [];
      debugPrint('Error fetching doa: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
