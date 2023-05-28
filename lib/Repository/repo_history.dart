import 'dart:developer';
import 'dart:convert';
import 'package:gofid_mobile_fix/Config/global.dart';
import 'package:gofid_mobile_fix/Models/History_Kelas.dart';
import 'package:http/http.dart' as http;
import 'package:gofid_mobile_fix/Models/booking_kelas.dart';

class HistoryMember {
  //History Kelas
  Future<List<HistoryKelas>> show(String idMember) async {
    String apiUrl = '$url/indexHistoryMemberKelas';
    List<HistoryKelas> data = [];
    try {
      var apiResult =
          await http.post(Uri.parse(apiUrl), body: {'ID_MEMBER': idMember});
      var jsonObject = json.decode(apiResult.body);

      if (jsonObject['data'] != null) {
        var historyKelasList = jsonObject['data'] as List<dynamic>;
        data = historyKelasList
            .map((item) => HistoryKelas.fromJson(item))
            .toList();
      }

      return data;
    } catch (e) {
      print('Error: $e');
      return data;
    }
  }
}
