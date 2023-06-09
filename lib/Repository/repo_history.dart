import 'dart:developer';
import 'dart:convert';
import 'package:gofid_mobile_fix/Config/global.dart';
import 'package:gofid_mobile_fix/Models/Model_History_Kelas.dart';
import 'package:gofid_mobile_fix/Models/Model_History_Kelas.dart';
import 'package:http/http.dart' as http;
import 'package:gofid_mobile_fix/Models/booking_kelas.dart';

import '../Models/ModelHistoryGymK.dart';
import '../Models/model_jadwal_harian.dart';
import '../Pages/Instruktur/history_instruktur.dart';

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

  Future<List<HistoryGym>> ShowHisotryGym(String ID_MEMBER) async {
    String apiUrl = '$url/indexHistoryMemberGym';
    List<HistoryGym> data = [];
    try {
      var apiResult =
          await http.post(Uri.parse(apiUrl), body: {'ID_MEMBER': ID_MEMBER});
      var jsonObject = json.decode(apiResult.body);

      if (jsonObject['data'] != null) {
        var HistoryGymList = jsonObject['data'] as List<dynamic>;
        data = HistoryGymList.map((item) => HistoryGym.fromJson(item)).toList();
      }

      return data;
    } catch (e) {
      print('Error: $e');
      return data;
    }
  }

  Future<List<dynamic>> ShowHistoryInstruktur(String ID_INSTRUKTUR) async {
    String apiUrl = '$url/indexHistoryInstruktur';
    List<dynamic> data = [];
    try {
      var apiResult = await http
          .post(Uri.parse(apiUrl), body: {'ID_INSTRUKTUR': ID_INSTRUKTUR});
      var jsonObject = json.decode(apiResult.body);

      if (jsonObject['data'] != null) {
        var historyInstrukturList = jsonObject['data'] as List<dynamic>;
        data = historyInstrukturList;
      }

      return data;
    } catch (e) {
      print('Error: $e');
      return data;
    }
  }
}
