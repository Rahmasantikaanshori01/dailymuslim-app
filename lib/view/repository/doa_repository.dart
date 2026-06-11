import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dailymuslim/view/model/doa_model.dart';

class DoaRepository {
  final String baseUrl = 'https://equran.id/api/doa';

  Future<List<Doa>> getAllDoa() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 30));

      // Debugging log
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // Jika respons berupa List langsung
        if (decoded is List) {
          return decoded.map((e) => Doa.fromJson(e)).toList();
        }

        // Jika respons berupa Map dengan key 'data'
        if (decoded is Map<String, dynamic> &&
            decoded.containsKey('data')) {
          final List data = decoded['data'];
          return data.map((e) => Doa.fromJson(e)).toList();
        }

        throw Exception('Format data tidak dikenali');
      } else {
        throw Exception(
            'Server error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching doa: $e');
      throw Exception('Gagal mengambil doa: $e');
    }
  }
}