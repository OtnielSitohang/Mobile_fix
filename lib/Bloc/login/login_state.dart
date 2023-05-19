// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types

part of 'login_bloc.dart';
// part of 'login_bloc.dart';

class LoginState {
  final String EMAIL_USER;
  final String PASSWORD_USER;
  User? user;
  Pegawai? pegawai;
  Instruktur? instruktur;
  Member? member;

  bool get isValidUsername => EMAIL_USER.isNotEmpty;
  bool get isValidPassword => PASSWORD_USER.isNotEmpty;

  final FormSumbissionStatus formStatus;

  // final String role;

  LoginState(
      {this.EMAIL_USER = '',
      this.PASSWORD_USER = '',
      this.formStatus = const InitialFormStatus(),
      this.user,
      this.instruktur,
      this.member,
      this.pegawai});

  LoginState copyWith(
      {String? EMAIL_USER,
      String? PASSWORD_USER,
      FormSumbissionStatus? formStatus = const InitialFormStatus(),
      String? role,
      User? user,
      Instruktur? instruktur,
      Pegawai? pegawai,
      Member? member}) {
    return LoginState(
        EMAIL_USER: EMAIL_USER ?? this.EMAIL_USER,
        PASSWORD_USER: PASSWORD_USER ?? this.PASSWORD_USER,
        formStatus: formStatus ?? this.formStatus,
        user: user ?? this.user,
        instruktur: instruktur ?? this.instruktur,
        member: member ?? this.member,
        pegawai: pegawai ?? this.pegawai);
  }
}
