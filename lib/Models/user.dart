// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types

class User {
  final String ID_USER;
  final String NAMA_USER;
  final String TANGGAL_DIBUAT_USER;
  final String FOTO_USER;
  final String EMAIL_USER;
  final String PASSWORD_USER;
  final String TANGGAL_LAHIR_USER;
  final String IS_DELETED_USER;

  final String? ID_PEGAWAI;
  final String? ID_MEMBER;
  final String? ID_INSTRUKTUR;

  User({
    required this.ID_USER,
    required this.NAMA_USER,
    required this.TANGGAL_DIBUAT_USER,
    required this.FOTO_USER,
    required this.EMAIL_USER,
    required this.PASSWORD_USER,
    required this.TANGGAL_LAHIR_USER,
    required this.IS_DELETED_USER,
    this.ID_PEGAWAI,
    this.ID_MEMBER,
    this.ID_INSTRUKTUR,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      ID_USER: json['ID_USER']?.toString() ?? '',
      NAMA_USER: json['NAMA_USER']?.toString() ?? '',
      TANGGAL_DIBUAT_USER: json['TANGGAL_DIBUAT_USER']?.toString() ?? '',
      FOTO_USER: json['FOTO_USER']?.toString() ?? '',
      EMAIL_USER: json['EMAIL_USER']?.toString() ?? '',
      PASSWORD_USER: json['PASSWORD_USER']?.toString() ?? '',
      TANGGAL_LAHIR_USER: json['TANGGAL_LAHIR_USER']?.toString() ?? '',
      IS_DELETED_USER: json['IS_DELETED_USER']?.toString() ?? '',
      ID_PEGAWAI: json['ID_PEGAWAI']?.toString(),
      ID_MEMBER: json['ID_MEMBER']?.toString(),
      ID_INSTRUKTUR: json['ID_INSTRUKTUR']?.toString(),
    );
  }
}
