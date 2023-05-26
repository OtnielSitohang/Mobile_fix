//* Import
import 'dart:developer';
import 'dart:convert';
import 'package:gofid_mobile_fix/Config/global.dart';
import 'package:http/http.dart' as http;
import 'package:gofid_mobile_fix/Models/booking_gym.dart';

class BookingGymRepository {
  Future<List> store(
      {required String idSesi,
      required String bookingDate,
      required String IdMember}) async {
    String apiUrl = '$url/bookinggym';
    try {
      var apiResult = await http.post(Uri.parse(apiUrl), body: {
        'id_member': IdMember,
        'tanggal_sesi_gym': bookingDate,
        'id_sesi': idSesi
      });
      //* + validasi di backend
      final responseData = jsonDecode(apiResult.body);
      final responseMessage = responseData['message'];
      if (apiResult.statusCode == 200) {
        return [responseMessage, true];
      } else if (apiResult.statusCode == 400) {
        return [responseMessage, false];
      } else {
        return ['Gagal Booking', false];
      }
    } catch (e) {
      inspect(e);
      return ['Gagal Booking', false];
    }
  }

  Future<List<BookingGym>> show(String idMember) async {
    String apiUrl = '$url/tampilbookinggym';
    List<BookingGym> data = [];
    try {
      var apiResult =
          await http.post(Uri.parse(apiUrl), body: {'id_member': idMember});
      var jsonObject = json.decode(apiResult.body);

      for (var item in jsonObject['data']) {
        data.add(BookingGym.fromJson(item));
      }
      inspect(data);
      return data;
    } catch (e) {
      inspect(e);
      return data;
    }
  }

  Future<List> cancelBooking(String noBooking) async {
    String apiUrl = '$url/cancelbookinggym/$noBooking';
    try {
      var apiResult = await http.put(
        Uri.parse(apiUrl),
      );
      inspect(apiResult);
      var jsonObject = json.decode(apiResult.body);
      final responseData = jsonDecode(apiResult.body);
      final responseMessage = responseData['message'];
      if (apiResult.statusCode == 200) {
        return [responseMessage, true];
      } else if (apiResult.statusCode == 400) {
        return [responseMessage, false];
      } else {
        return ['Gagal Membatalkan Booking', false];
      }
    } catch (e) {
      inspect(e);
      return ['Gagal'];
    }
  }
}
