// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/form_submission_status.dart';
import 'package:gofid_mobile_fix/Models/user.dart';
import 'package:gofid_mobile_fix/Models/instruktur.dart';
import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/pegawai.dart';
import 'package:gofid_mobile_fix/Repository/repo_auth.dart';
// import 'package:mobile_app_gofit_0541/Repository/repo_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepo = AuthRepository();

  LoginBloc() : super(LoginState()) {
    //* on Event state ()
    on<LoginUsernameChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<Logout>(_onLogoutSubmitted);
  }

  //* Mencatat perubahan pada form email
  _onEmailChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(EMAIL_USER: event.EMAIL_USER));
  }

  //* Mencatat perubahan pada form password
  _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(PASSWORD_USER: event.PASSWORD_USER));
  }

  //* saat tombol submit di pencet
  _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    //*State menjadi submitting
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      //*request login
      final response = await authRepo.login(
          EMAIL_USER: state.EMAIL_USER, PASSWORD_USER: state.PASSWORD_USER);
      if (response != null) {
        emit(state.copyWith(user: response));
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } else {
        return emit(state.copyWith(formStatus: SubmissionFailed()));
      }
    } catch (e) {
      emit(state.copyWith(
          formStatus: SubmissionFailed(exception: e as Exception)));
    }
  }
  //* Akhir dari fungsi tombol submit

  // * saat logout , hapus data username dan password dari state
  // _onLogoutSubmitted(Logout event, Emitter<LoginState> emit) {
  //   emit(state.copyWith(
  //     EMAIL_USER: '',
  //     PASSWORD_USER: '',
  //   ));
  // }

  _onLogoutSubmitted(Logout event, Emitter<LoginState> emit) {
    emit(LoginState()); // Mengatur ulang state menjadi state awal
  }
}
