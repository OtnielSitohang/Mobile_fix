import 'package:gofid_mobile_fix/Models/kelas.dart';
import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/user.dart';

import 'model_jadwal_harian.dart';

class HistoryInstruktur {
  final String ID_JADWAL;
  final String ID_KELAS;
  final String JAD_ID_JADWAL;
  final String ID_USER;
  final String ID_INSTRUKTUR;
  final int SESI_JADWAL;
  final dynamic IS_CANCELED;
  final int SESI_BOOKING_GYM;
  final dynamic IS_DELETED_JADWAL;
  final Kelas kelas;
  final JadwalHarianModel jadwal_harian;

  HistoryInstruktur({
    required this.ID_JADWAL,
    required this.ID_KELAS,
    required this.JAD_ID_JADWAL,
    required this.ID_USER,
    required this.ID_INSTRUKTUR,
    required this.SESI_JADWAL,
    required this.IS_CANCELED,
    required this.SESI_BOOKING_GYM,
    required this.IS_DELETED_JADWAL,
    required this.kelas,
    required this.jadwal_harian,
  });

  factory HistoryInstruktur.fromJson(Map<String, dynamic> json) {
    return HistoryInstruktur(
      ID_JADWAL: json['ID_JADWAL'],
      ID_KELAS: json['ID_KELAS'],
      JAD_ID_JADWAL: json['JAD_ID_JADWAL'],
      ID_USER: json['ID_USER'],
      ID_INSTRUKTUR: json['ID_INSTRUKTUR'],
      SESI_JADWAL: json['SESI_JADWAL'],
      IS_CANCELED: json['IS_CANCELED'],
      SESI_BOOKING_GYM: json['SESI_BOOKING_KELAS'],
      IS_DELETED_JADWAL: json['IS_DELETED_JADWAL'],
      kelas: Kelas.fromJson(json['kelas']),
      jadwal_harian: JadwalHarianModel.fromJson(json['jadwal_harian']),
    );
  }
}
