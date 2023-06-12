import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/list_ijin.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/presensi_kelas_page.dart';
import 'package:http/http.dart' as http;
import '../../Bloc/login/login_bloc.dart';
import '../../Config/global.dart';
import 'package:intl/intl.dart';

class KelasHariIni extends StatefulWidget {
  const KelasHariIni({super.key});

  @override
  State<KelasHariIni> createState() => _KelasHariIniState();
}

class _KelasHariIniState extends State<KelasHariIni> {
  static String get baseUrl => url;
  List<dynamic> KelasToday = [];
  late String loggedInUserID;

  @override
  void initState() {
    super.initState();
    loggedInUserID = getLoggedInUserID();
    fetchHistoryData(); // Panggil fungsi untuk mengambil data instruktur
  }

  String getLoggedInUserID() {
    String? ID_INSTRUKTUR =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_INSTRUKTUR;
    return ID_INSTRUKTUR ?? '';
  }

  String getLoggedInUserName(BuildContext context) {
    String? namaUser =
        BlocProvider.of<LoginBloc>(context).state.user?.NAMA_USER;
    return namaUser ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/GetDataInsToday/$loggedInUserID';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null) {
          setState(() {
            KelasToday = List.from(jsonData['data']);
            // inspect(KelasToday);
          });
        }
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;
    final fontSize = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Welcome ${getLoggedInUserName(context)}'),
            Text(
              'Anda login sebagai instruktur',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade200, Colors.blue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Kelas Anda Hari ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          KelasToday.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: KelasToday.length,
                    itemBuilder: (context, index) {
                      var history = KelasToday[index] as Map<String, dynamic>;
                      var NAMA_KELAS = history['NAMA_KELAS'];
                      var SLOT_KELAS = 10 - history['SLOT_KELAS'];
                      var WAKTU_MULAI = history['WAKTU_MULAI'];
                      var HARGA_KELAS = history['HARGA_KELAS'];
                      var formattedHargaKelas =
                          currencyFormat.format(HARGA_KELAS);

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade200,
                                Colors.blue.shade400
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Container(
                            width: cardWidth,
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kelas $NAMA_KELAS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  SLOT_KELAS.toString() +
                                      ' Orang yang melakukan booking',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  WAKTU_MULAI != null
                                      ? 'Dimulai Pada $WAKTU_MULAI'
                                      : 'Kelas belum dipresensi, belum dimulai',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Harga Kelas $formattedHargaKelas',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: WAKTU_MULAI != null
                                      ? () {
                                          // Logika saat tombol ditekan
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PresensiKelasPage(
                                                idJadwalHarian:
                                                    history['ID_JADWAL_HARIAN'],
                                                idInstruktur:
                                                    history['ID_INSTRUKTUR'],
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Text('Presensi Member'),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .red; // Warna saat tombol dinonaktifkan
                                      }
                                      return Colors
                                          .green; // Warna saat tombol aktif
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Card(
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.red.shade200, Colors.red.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Kelas Anda Kosong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
