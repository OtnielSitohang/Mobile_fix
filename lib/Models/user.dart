// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types
// import 'mo';

import 'package:gofid_mobile_fix/Models/kelas.dart';
import 'dart:developer';

class User {
  final String ID_USER;
  final String NAMA_USER;
  final String TANGGAL_DIBUAT_USER;
  final String FOTO_USER;
  final String EMAIL_USER;
  final String PASSWORD_USER;
  final String TANGGAL_LAHIR_USER;
  final String IS_DELETED_USER;

  //Instruktur
  final String? DESKRIPSI_INSTRUKTUR;
  final String? KETERLAMBATAN_INSTRUKTUR;
  //Pegawai
  final String? ID_PEGAWAI;
  //Meber
  final String? ID_MEMBER;
  final String? ALAMAT_MEMBER;
  final String? TELEPON_MEMBER;
  final String? SISA_DEPOSIT_MEMBER;
  final String? TANGGAL_KADALUARSA_MEMBERSHIP;
  final String? TOTAL_KELAS;
  final String? ID_KELAS;

  Kelas? kelas;

  //Instruktur
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
    this.ID_MEMBER,
    this.ALAMAT_MEMBER,
    this.TANGGAL_KADALUARSA_MEMBERSHIP,
    this.TELEPON_MEMBER,
    this.SISA_DEPOSIT_MEMBER,
    this.TOTAL_KELAS,
    this.ID_KELAS,
    this.kelas,

    //Instruktur
    this.DESKRIPSI_INSTRUKTUR,
    this.KETERLAMBATAN_INSTRUKTUR,

    //Pegawai
    this.ID_PEGAWAI,
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
      ALAMAT_MEMBER: json['ALAMAT_MEMBER']?.toString(),
      TELEPON_MEMBER: json['TELEPON_MEMBER']?.toString(),
      TOTAL_KELAS: json['TOTAL_KELAS']?.toString(),
      ID_KELAS: json['ID_KELAS ']?.toString(),
      SISA_DEPOSIT_MEMBER: json['SISA_DEPOSIT_MEMBER']?.toString(),
      TANGGAL_KADALUARSA_MEMBERSHIP:
          json['TANGGAL_KADALUARSA_MEMBERSHIP']?.toString(),
      kelas: (json['kelas'] != null) ? Kelas.fromJson(json['kelas']) : null,

      //Instruktur
      ID_INSTRUKTUR: json['ID_INSTRUKTUR']?.toString(),
      DESKRIPSI_INSTRUKTUR: json['DESKRIPSI_INSTRUKTUR']?.toString(),
      KETERLAMBATAN_INSTRUKTUR: json['KETERLAMBATAN_INSTRUKTUR']?.toString(),
    );
  }
}
