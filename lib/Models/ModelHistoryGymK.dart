import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/user.dart';

class HistoryGym {
  final String ID_BOOKING_PRESENSI_GYM;
  final String ID_USER;
  final String ID_MEMBER;
  final String NO_STRUK_PRESENSI_MEMBER_GYM;
  final String TANGGAL_BOOKING_GYM;
  final String TANGGAL_GYM;
  final int STATUS_PRESENSI;
  final dynamic IS_CANCELED;
  final int SESI_BOOKING_GYM;
  final dynamic IS_DELETED_BOOKING_GYM;
  final User user;
  final Member member;

  HistoryGym({
    required this.ID_BOOKING_PRESENSI_GYM,
    required this.ID_USER,
    required this.ID_MEMBER,
    required this.NO_STRUK_PRESENSI_MEMBER_GYM,
    required this.TANGGAL_BOOKING_GYM,
    required this.TANGGAL_GYM,
    required this.STATUS_PRESENSI,
    required this.IS_CANCELED,
    required this.SESI_BOOKING_GYM,
    required this.IS_DELETED_BOOKING_GYM,
    required this.user,
    required this.member,
  });

  factory HistoryGym.fromJson(Map<String, dynamic> json) {
    return HistoryGym(
      ID_BOOKING_PRESENSI_GYM: json['ID_BOOKING_PRESENSI_GYM'],
      ID_USER: json['ID_JADWAL'],
      ID_MEMBER: json['ID_USER'],
      NO_STRUK_PRESENSI_MEMBER_GYM: json['ID_MEMBER'],
      TANGGAL_BOOKING_GYM: json['NO_STRUK_PRESENSI_KELAS'],
      TANGGAL_GYM: json['TANGGAL_GYM'],
      STATUS_PRESENSI: json['STATUS_PRESENSI'],
      IS_CANCELED: json['IS_CANCELED'],
      SESI_BOOKING_GYM: json['SESI_BOOKING_GYM'],
      IS_DELETED_BOOKING_GYM: json['IS_DELETED_BOOKING_GYM'],
      user: User.fromJson(json['user']),
      member: Member.fromJson(json['m_e_m_b_e_r']),
    );
  }
}
