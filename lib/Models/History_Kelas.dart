import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/user.dart';

class HistoryKelas {
  final String idBookingKelas;
  final String idJadwal;
  final String idUser;
  final String idMember;
  final String noStrukPresensiKelas;
  final String tanggalKelas;
  final int statusPresensi;
  final dynamic isCanceled;
  final int sesiBookingKelas;
  final String tanggalBookingKelas;
  final dynamic isDeletedBookingKelas;
  final User user;
  final Member member;

  HistoryKelas({
    required this.idBookingKelas,
    required this.idJadwal,
    required this.idUser,
    required this.idMember,
    required this.noStrukPresensiKelas,
    required this.tanggalKelas,
    required this.statusPresensi,
    required this.isCanceled,
    required this.sesiBookingKelas,
    required this.tanggalBookingKelas,
    required this.isDeletedBookingKelas,
    required this.user,
    required this.member,
  });

  factory HistoryKelas.fromJson(Map<String, dynamic> json) {
    return HistoryKelas(
      idBookingKelas: json['ID_BOOKING_KELAS'],
      idJadwal: json['ID_JADWAL'],
      idUser: json['ID_USER'],
      idMember: json['ID_MEMBER'],
      noStrukPresensiKelas: json['NO_STRUK_PRESENSI_KELAS'],
      tanggalKelas: json['TANGGAL_KELAS'],
      statusPresensi: json['STATUS_PRESENSI'],
      isCanceled: json['IS_CANCELED'],
      sesiBookingKelas: json['SESI_BOOKING_KELAS'],
      tanggalBookingKelas: json['TANGGAL_BOOKING_KELAS'],
      isDeletedBookingKelas: json['IS_DELETED_BOOKING_KELAS'],
      user: User.fromJson(json['user']),
      member: Member.fromJson(json['m_e_m_b_e_r']),
    );
  }
}
