//* State dari AppBloc.dart;

// ignore_for_file: non_constant_identifier_names

part of 'app_bloc.dart';

class AppState {
  final User? user;
  final Pegawai? pegawai;
  final Member? member;
  final Instruktur? instruktur;

  AppState({this.user, this.pegawai, this.instruktur, this.member});

  AppState copyWith({
    User? user,
    Pegawai? pegawai,
    Member? member,
    Instruktur? instruktur,
  }) {
    return AppState(
      user: user ?? this.user,
      pegawai: pegawai ?? this.pegawai,
      member: member ?? this.member,
      instruktur: instruktur ?? this.instruktur,
    );
  }
}
