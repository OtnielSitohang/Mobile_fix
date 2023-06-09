import 'dart:convert';
import 'package:gofid_mobile_fix/Config/global.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchJadwalHarian(String idInstruktur) async {
  String apiUrl = '$url/GetJadwalByIns';
  List<dynamic> data = [];

  try {
    var apiResult = await http
        .post(Uri.parse(apiUrl), body: {'ID_INSTRUKTUR': idInstruktur});
    var jsonObject = json.decode(apiResult.body);

    if (jsonObject['data'] != null) {
      data = jsonObject['data'] as List<dynamic>;
    }

    return data;
  } catch (e) {
    print('Error: $e');
    return data;
  }
}
