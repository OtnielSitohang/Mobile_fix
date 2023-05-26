import 'dart:developer';
import 'package:gofid_mobile_fix/Models/sesi_gym.dart';

class BookingGym {
  final String? ID_BOOKING_PRESENSI_GYM;
  final String? ID_USER;
  final String? ID_MEMBER;
  final String? NO_STRUK_PRESENSI_MEMBER_GYM;
  final String? TANGGAL_BOOKING_GYM;
  final String? TANGGAL_GYM;
  final String? STATUS_PRESENSI;
  final String? IS_CANCELED;
  Sesi? sesi;

  BookingGym(
      {required this.ID_BOOKING_PRESENSI_GYM,
      this.ID_USER,
      this.ID_MEMBER,
      required this.NO_STRUK_PRESENSI_MEMBER_GYM,
      required this.TANGGAL_BOOKING_GYM,
      required this.TANGGAL_GYM,
      required this.STATUS_PRESENSI,
      this.sesi,
      required this.IS_CANCELED});

  factory BookingGym.fromJson(Map<String, dynamic> json) {
    return BookingGym(
      ID_BOOKING_PRESENSI_GYM: json['ID_BOOKING_PRESENSI_GYM'].toString(),
      ID_USER: json['ID_USER'].toString(),
      ID_MEMBER: json['ID_MEMBER'].toString(),
      NO_STRUK_PRESENSI_MEMBER_GYM:
          json['NO_STRUK_PRESENSI_MEMBER_GYM'].toString(),
      TANGGAL_BOOKING_GYM: json['TANGGAL_BOOKING_GYM'].toString(),
      TANGGAL_GYM: json['TANGGAL_GYM'].toString(),
      STATUS_PRESENSI: json['STATUS_PRESENSI'].toString(),
      sesi: Sesi.fromJson(json['sesi']),
      IS_CANCELED: json['IS_CANCELED'].toString(),
    );
  }
}
