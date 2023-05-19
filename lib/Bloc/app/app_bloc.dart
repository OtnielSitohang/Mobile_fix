import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Models/instruktur.dart';
import 'package:gofid_mobile_fix/Models/member.dart';
import 'package:gofid_mobile_fix/Models/user.dart';
import 'package:gofid_mobile_fix/Models/pegawai.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(AppState(
            user: User(
          ID_USER: '',
          NAMA_USER: '',
          TANGGAL_DIBUAT_USER: '',
          FOTO_USER: '',
          EMAIL_USER: '',
          PASSWORD_USER: '',
          TANGGAL_LAHIR_USER: '',
          IS_DELETED_USER: '',
        ))) {
    on<SaveUserInfo>(_saveUserInfo);
  }

  _saveUserInfo(SaveUserInfo event, Emitter<AppState> emit) {
    emit(state.copyWith(
        user: event.user,
        instruktur: event.instruktur,
        member: event.member,
        pegawai: event.pegawai));
    // debugPrint();
  }
}
