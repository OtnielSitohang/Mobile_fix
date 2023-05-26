// ignore_for_file: non_constant_identifier_names

class Kelas {
  String? ID_KELAS;
  String? NAMA_KELAS;
  String? HARGA_KELAS;
  String? KAPASITAS_KELAS;
  String? IS_DELETED_KELAS;

  Kelas({
    required this.ID_KELAS,
    required this.NAMA_KELAS,
    required this.HARGA_KELAS,
    required this.KAPASITAS_KELAS,
    required this.IS_DELETED_KELAS,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      ID_KELAS: json['ID_KELAS'].toString(),
      NAMA_KELAS: json['NAMA_KELAS'].toString(),
      HARGA_KELAS: json['HARGA_KELAS'].toString(),
      KAPASITAS_KELAS: json['KAPASITAS_KELAS'].toString(),
      IS_DELETED_KELAS: json['IS_DELETED_KELAS'].toString(),
    );
  }
}
