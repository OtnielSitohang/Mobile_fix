class JadwalHarianModel {
  final String ID_JADWAL;
  final String ID_JADWAL_HARIAN;
  final String TANGGAL_JADWAL_HARIAN;
  final String HARI_JADWAL_HARIAN;
  final String STATUS;
  final String IS_DELETED_JADWAL_HARIAN;
  final String WAKTU_MULAI;
  final String WAKTU_SELESAI;
  final String ID_KELAS;
  final String JAD_ID_JADWAL;
  final String ID_USER;
  final String ID_INSTRUKTUR;
  final String SESI_JADWAL;
  final String IS_DELETED_JADWAL;
  final String NAMA_USER;
  final String NAMA_KELAS;
  final String KAPASITAS_KELAS;

  JadwalHarianModel({
    required this.ID_JADWAL,
    required this.ID_JADWAL_HARIAN,
    required this.TANGGAL_JADWAL_HARIAN,
    required this.HARI_JADWAL_HARIAN,
    required this.STATUS,
    required this.IS_DELETED_JADWAL_HARIAN,
    required this.WAKTU_MULAI,
    required this.WAKTU_SELESAI,
    required this.ID_KELAS,
    required this.JAD_ID_JADWAL,
    required this.ID_USER,
    required this.ID_INSTRUKTUR,
    required this.SESI_JADWAL,
    required this.IS_DELETED_JADWAL,
    required this.NAMA_USER,
    required this.NAMA_KELAS,
    required this.KAPASITAS_KELAS,
  });

  factory JadwalHarianModel.fromJson(Map<String, dynamic> json) {
    return JadwalHarianModel(
      ID_JADWAL: json['ID_JADWAL']?.toString() ?? '',
      ID_JADWAL_HARIAN: json['ID_JADWAL_HARIAN']?.toString() ?? '',
      TANGGAL_JADWAL_HARIAN: json['TANGGAL_JADWAL_HARIAN']?.toString() ?? '',
      HARI_JADWAL_HARIAN: json['HARI_JADWAL_HARIAN']?.toString() ?? '',
      STATUS: json['STATUS']?.toString() ?? '',
      IS_DELETED_JADWAL_HARIAN:
          json['IS_DELETED_JADWAL_HARIAN']?.toString() ?? '',
      WAKTU_MULAI: json['WAKTU_MULAI']?.toString() ?? '',
      WAKTU_SELESAI: json['WAKTU_SELESAI']?.toString() ?? '',
      ID_KELAS: json['ID_KELAS']?.toString() ?? '',
      JAD_ID_JADWAL: json['JAD_ID_JADWAL']?.toString() ?? '',
      ID_USER: json['ID_USER']?.toString() ?? '',
      ID_INSTRUKTUR: json['ID_INSTRUKTUR']?.toString() ?? '',
      SESI_JADWAL: json['SESI_JADWAL']?.toString() ?? '',
      IS_DELETED_JADWAL: json['IS_DELETED_JADWAL']?.toString() ?? '',
      NAMA_USER: json['NAMA_USER']?.toString() ?? '',
      NAMA_KELAS: json['NAMA_KELAS']?.toString() ?? '',
      KAPASITAS_KELAS: json['KAPASITAS_KELAS']?.toString() ?? '',
    );
  }
}
