//* Setingan URL disesuaikan
import 'package:gofid_mobile_fix/Pages/Instruktur/navbarInstruktur.dart';
import 'package:gofid_mobile_fix/Pages/Member/Profile/navbarAndHomeMember.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/navbarInstruktur.dart';
import 'package:gofid_mobile_fix/Pages/Member/Profile/index_member.dart';
import 'package:gofid_mobile_fix/Pages/home_pegawai.dart';
import 'package:gofid_mobile_fix/Pages/login_page.dart';

String url = 'http://192.168.149.83:5000/api';

var routesApp = {
  '/loginMobile2': (context) => const LoginPage(),
  '/homeMember': (context) => const HomeMember(),
  '/homeInstruktur': (context) => const HomeInstruktur(),
  '/homePegawai': (context) => const HomePegawai(),
  // '/homeInstruktur' : (context) => const HomePageInstruktur(),
  // '/changepw' : (context) => const ChangePasswordPage(),
  // '/profilePegawai' : (context) => const ProfilePegawai(),
  // '/ijin' : (context) => const IjinPages(),
  // '/riwayatijin' : (context) => const RiwayatIjinPage()
};
