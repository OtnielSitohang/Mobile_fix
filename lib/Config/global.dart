//* Setingan URL disesuaikan
import 'package:gofid_mobile_fix/Pages/login_page.dart';

String url = 'http://192.168.3.125:5000/api';

var routesApp = {
  '/login': (context) => const LoginPage(),
  // '/homeMember': (context) => const HomePageMember(),
  // '/homeMember': (context) => const MemberPage(),
  // '/homePegawai': (context) => const HomePagePegawai(),
  // '/homeInstruktur' : (context) => const HomePageInstruktur(),
  // '/changepw' : (context) => const ChangePasswordPage(),
  // '/profilePegawai' : (context) => const ProfilePegawai(),
  // '/ijin' : (context) => const IjinPages(),
  // '/riwayatijin' : (context) => const RiwayatIjinPage()
};
