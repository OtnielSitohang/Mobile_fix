//* Setingan URL disesuaikan
import 'package:gofid_mobile_fix/Pages/Instruktur/kelas_today.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/navbarInstruktur.dart';
import 'package:gofid_mobile_fix/Pages/Member/navbarAndHomeMember.dart';
import 'package:gofid_mobile_fix/Pages/Member/index_member.dart';
import 'package:gofid_mobile_fix/Pages/Pegawai/Manager/home_manager.dart';
import 'package:gofid_mobile_fix/Pages/login_page.dart';

import '../Pages/Pegawai/Manager/page_navbar_manager.dart';

String url = 'http://192.168.3.141:5000/api';

var routesApp = {
  '/loginMobile2': (context) => const LoginPage(),
  '/homeMember': (context) => const HomeMember(),
  '/homeInstruktur': (context) => const HomeInstruktur(),
  '/homePegawai': (context) => const NavbarManager(),
  '/kelas_today': (context) => const KelasHariIni(),
  // '/indexHistoryMemberKelas': (context) => const HomePegawai(),

  // '/homeInstruktur' : (context) => const HomePageInstruktur(),
  // '/changepw' : (context) => const ChangePasswordPage(),
  // '/profilePegawai' : (context) => const ProfilePegawai(),
  // '/ijin' : (context) => const IjinPages(),
  // '/riwayatijin' : (context) => const RiwayatIjinPage()
};
