// ignore_for_file: non_constant_identifier_names

class Member {
  String? ID_USER;
  String? ID_MEMBER;
  String? ALAMAT_MEMBER;
  String? TELEPON_MEMBER;
  String? SISA_DEPOSIT_MEMBER;
  String? TANGGAL_KADALUARSA_MEMBERSHIP;
  String? TANGGAL_LAHIR_USER;
  String? TOTAL_KELAS;
  String? IS_DELETED_MEMBER;

  Member({
    this.ID_USER,
    this.ID_MEMBER,
    this.ALAMAT_MEMBER,
    this.TELEPON_MEMBER,
    this.SISA_DEPOSIT_MEMBER,
    this.TANGGAL_LAHIR_USER,
    this.TOTAL_KELAS,
    this.IS_DELETED_MEMBER,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      ID_USER: json['ID_USER']?.toString() ?? '',
      ID_MEMBER: json['ID_MEMBER']?.toString() ?? '',
      ALAMAT_MEMBER: json['ALAMAT_MEMBER']?.toString() ?? '',
      TELEPON_MEMBER: json['TELEPON_MEMBER']?.toString() ?? '',
      SISA_DEPOSIT_MEMBER: json['SISA_DEPOSIT_MEMBER']?.toString() ?? '',
      TANGGAL_LAHIR_USER: json['TANGGAL_LAHIR_USER']?.toString() ?? '',
      IS_DELETED_MEMBER: json['IS_DELETED_MEMBER']?.toString() ?? '',
      TOTAL_KELAS: json['TOTAL_KELAS']?.toString() ?? '',
    );
  }
}
