import 'dart:developer';
import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/sesi_gym.dart';
import 'package:gofid_mobile_fix/Models/user.dart';

class BookingKelas {
  final String? ID_BOOKING_KELAS;
  final String? ID_JADWAL;
  final String? ID_USER;
  final String? ID_MEMBER;
  final String? NO_STRUK_PRESENSI_KELAS;
  final String? TANGGAL_KELAS;
  final String? STATUS_PRESENSI;
  final String? IS_CANCELED;
  final String? SESI_BOOKING_KELAS;
  final String? TANGGAL_BOOKING_KELAS;
  User user;
  Member member;

  BookingKelas({
    required this.ID_BOOKING_KELAS,
    this.ID_JADWAL,
    this.ID_USER,
    required this.ID_MEMBER,
    required this.NO_STRUK_PRESENSI_KELAS,
    required this.TANGGAL_KELAS,
    required this.STATUS_PRESENSI,
    // this.sesi,
    required this.IS_CANCELED,
    required this.SESI_BOOKING_KELAS,
    required this.TANGGAL_BOOKING_KELAS,
    required this.user,
    required this.member,
  });

  factory BookingKelas.fromJson(Map<String, dynamic> json) {
    return BookingKelas(
      ID_BOOKING_KELAS: json['ID_BOOKING_KELAS'].toString(),
      ID_JADWAL: json['ID_JADWAL'].toString(),
      ID_USER: json['ID_USER'].toString(),
      ID_MEMBER: json['ID_MEMBER'].toString(),
      NO_STRUK_PRESENSI_KELAS: json['NO_STRUK_PRESENSI_KELAS'].toString(),
      TANGGAL_KELAS: json['TANGGAL_KELAS'].toString(),
      STATUS_PRESENSI: json['STATUS_PRESENSI'].toString(),
      IS_CANCELED: json['IS_CANCELED'].toString(),
      SESI_BOOKING_KELAS: json['SESI_BOOKING_KELAS'].toString(),
      TANGGAL_BOOKING_KELAS: json['TANGGAL_BOOKING_KELAS'].toString(),
      user: User.fromJson(json['user']),
      member: Member.fromJson(json['m_e_m_b_e_r']),
    );
  }
}
