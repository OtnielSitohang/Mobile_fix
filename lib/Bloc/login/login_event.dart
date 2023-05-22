// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types

part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String? EMAIL_USER;
  LoginUsernameChanged({this.EMAIL_USER});
}

class LoginPasswordChanged extends LoginEvent {
  final String? PASSWORD_USER;

  LoginPasswordChanged({this.PASSWORD_USER});
}

class LoginSubmitted extends LoginEvent {
  final User? user;

  LoginSubmitted({this.user});
}

class Logout extends LoginEvent {
  final String? EMAIL_USER;
  final String? PASSWORD_USER;

  Logout({this.EMAIL_USER, this.PASSWORD_USER});
}
