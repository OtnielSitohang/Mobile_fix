// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types
class Pegawai {
  String? ID_USER;
  String? ID_PEGAWAI;
  String? JABATAN_PEGAWAI;
  String? IS_DELETED_PEGAWAI;

  //* Constructor
  Pegawai({
    this.ID_USER,
    this.ID_PEGAWAI,
    this.JABATAN_PEGAWAI,
    this.IS_DELETED_PEGAWAI,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      ID_USER: json['ID_USER']?.toString() ?? '',
      ID_PEGAWAI: json['ID_PEGAWAI']?.toString() ?? '',
      JABATAN_PEGAWAI: json['JABATAN_PEGAWAI']?.toString() ?? '',
      IS_DELETED_PEGAWAI: json['']?.toString() ?? '',
    );
  }

  // Map mapJson(String key) => json[key]?.toString() ??  '';
}
