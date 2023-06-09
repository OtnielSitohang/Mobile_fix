// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class Instruktur {
  String? ID_USER;
  String? ID_INSTRUKTUR;
  String? DESKRIPSI_INSTRUKTUR;
  // Int? KETERLAMBATAN_INSTRUKTUR;
  String? IS_DELETED_INSTRUKTUR;

  Instruktur({
    required this.ID_USER,
    required this.ID_INSTRUKTUR,
    required this.DESKRIPSI_INSTRUKTUR,
    required this.IS_DELETED_INSTRUKTUR,
    // required this.KETERLAMBATAN_INSTRUKTUR,
  });

  factory Instruktur.fromJson(Map<String, dynamic> json) {
    return Instruktur(
      ID_USER: json['ID_USER'].toString(),
      ID_INSTRUKTUR: json['ID_INSTRUKTUR'].toString(),
      DESKRIPSI_INSTRUKTUR: json['DESKRIPSI_INSTRUKTUR'].toString(),
      IS_DELETED_INSTRUKTUR: json['IS_DELETED_INSTRUKTUR'].toString(),
      // KETERLAMBATAN_INSTRUKTUR: json['KETERLAMBATAN_INSTRUKTUR'].toString(),
    );
  }
}
