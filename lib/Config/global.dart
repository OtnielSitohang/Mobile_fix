//* Setingan URL disesuaikan
import 'package:gofid_mobile_fix/Pages/Instruktur/navbarInstruktur.dart';
import 'package:gofid_mobile_fix/Pages/Member/navbarAndHomeMember.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/navbarInstruktur.dart';
import 'package:gofid_mobile_fix/Pages/Member/index_member.dart';
import 'package:gofid_mobile_fix/Pages/home_pegawai.dart';
import 'package:gofid_mobile_fix/Pages/login_page.dart';

String url = 'http://192.168.77.130:5000/api';

var routesApp = {
  '/loginMobile2': (context) => const LoginPage(),
  '/homeMember': (context) => const HomeMember(),
  '/homeInstruktur': (context) => const HomeInstruktur(),
  '/homePegawai': (context) => const HomePegawai(),
  // '/indexHistoryMemberKelas': (context) => const HomePegawai(),

  // '/homeInstruktur' : (context) => const HomePageInstruktur(),
  // '/changepw' : (context) => const ChangePasswordPage(),
  // '/profilePegawai' : (context) => const ProfilePegawai(),
  // '/ijin' : (context) => const IjinPages(),
  // '/riwayatijin' : (context) => const RiwayatIjinPage()
};
