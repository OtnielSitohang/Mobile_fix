//* Template Response dari API
import 'dart:developer';

import 'package:gofid_mobile_fix/Models/instruktur.dart';
import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/user.dart';
import 'package:gofid_mobile_fix/Models/pegawai.dart';

class LoginResult {
  String message;
  String accessToken;
  User user;
  Pegawai? pegawai;
  Member? member;
  Instruktur? instruktur;
  //* Constructor
  LoginResult({
    required this.message,
    required this.accessToken,
    required this.user,
    this.pegawai,
    this.member,
    this.instruktur,
  });

  //* Factory Method
  factory LoginResult.createLoginResult(Map<String, dynamic> object) {
    if (object['pegawai'] != null) {
      return LoginResult(
        message: object['message'],
        accessToken: object['access_token'],
        user: User.fromJson(object['user']),
        pegawai: Pegawai.fromJson(object['pegawai']),
      );
    } else if (object['member'] != null) {
      return LoginResult(
          message: object['message'],
          accessToken: object['access_token'],
          user: User.fromJson(object['user']),
          member: Member.fromJson(object['member']));
    } else if (object['instruktur'] != null) {
      return LoginResult(
          message: object['message'],
          accessToken: object['access_token'],
          user: User.fromJson(object['user']),
          instruktur: Instruktur.fromJson(object[
              'instruktur']) //object ['instruktur']['id_instruktur'].toString(),
          );
    } else {
      return LoginResult(
        message: object['message'],
        accessToken: object['access_token'],
        user: User.fromJson(object['user']),
      );
    }
  }
}
