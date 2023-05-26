class Sesi {
  String? idSesi;
  String? waktuMulai;
  String? waktuSelesai;

  Sesi({this.idSesi, this.waktuMulai, this.waktuSelesai});

  factory Sesi.fromJson(Map<String, dynamic> json) {
    return Sesi(
        idSesi: json['id_sesi']?.toString() ?? '',
        waktuMulai: json['waktu_mulai']?.toString() ?? '',
        waktuSelesai: json['waktu_selesai']?.toString() ?? '');
  }
}
