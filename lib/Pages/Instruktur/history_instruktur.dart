import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';
import 'package:gofid_mobile_fix/Config/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class HistoryInstruktur extends StatefulWidget {
  @override
  _HistoryInstrukturState createState() => _HistoryInstrukturState();
}

class _HistoryInstrukturState extends State<HistoryInstruktur> {
  List<dynamic> historyData = [];
  List<dynamic> historyIzin = [];
  late String loggedInUserID;

  @override
  void initState() {
    super.initState();
    loggedInUserID = getLoggedInUserID();
    fetchHistoryData();
  }

  String getLoggedInUserID() {
    String? ID_INSTRUKTUR =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_INSTRUKTUR;
    return ID_INSTRUKTUR ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/indexHistoryInstruktur/$loggedInUserID';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null || jsonData['instruktur'] != null) {
          setState(() {
            historyData = List.from(jsonData['data']);
            historyIzin = List.from(jsonData['instruktur']);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('History Instruktur'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: historyData.length + historyIzin.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Section title: History Kelas
            return Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'History Kelas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (index <= historyData.length) {
            if (historyData.isEmpty) {
              // Section title: History Kelas (empty)
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'History Data Kosong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              var history = historyData[index - 1];
              var NAMA_KELAS = history['NAMA_KELAS'];
              NumberFormat currencyFormat =
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
              String formattedPrice =
                  currencyFormat.format(history['HARGA_KELAS']);

              var HARI_JADWAL_HARIAN = history['HARI_JADWAL_HARIAN'];
              var TANGGAL_JADWAL_HARIAN = history['TANGGAL_JADWAL_HARIAN'];
              var SESI_JADWAL = history['SESI_JADWAL'];
              var SLOT_KELAS = history['SLOT_KELAS'];

              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = constraints.maxWidth;
                      final cardWidth = screenWidth * 0.9;
                      final fontSize = screenWidth * 0.04;

                      return Container(
                        width: cardWidth,
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kelas $NAMA_KELAS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Pada Hari ${GetHariJadwalhariaj(HARI_JADWAL_HARIAN)}',
                              style: TextStyle(
                                fontSize: fontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              TANGGAL_JADWAL_HARIAN.toString(),
                              style: TextStyle(
                                fontSize: fontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              GetSesiTetx(SESI_JADWAL),
                              style: TextStyle(
                                fontSize: fontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              formattedPrice,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              SLOT_KELAS.toString() + ' Orang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } else if (index == historyData.length + 1) {
            // Section title: History Izin
            return Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'History Izin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (index <= historyData.length + historyIzin.length + 1) {
            if (historyIzin.isEmpty) {
              // Section title: History Izin (empty)
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'History Izin Kosong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              var instruktur = historyIzin[index - historyData.length - 2];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID Izin ${instruktur['ID_IJIN_INSTRUKTUR']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Kelas ${instruktur['NAMA_KELAS']} digantikan Oleh ${instruktur['instruktur_pengganti_user_name']['NAMA_USER']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Pada ${instruktur['TANGGAL_IZIN']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Diajukan Pada ${instruktur['TANGGAL_PENGAJUAN_IZIN']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

String getPresensiText(int presensi) {
  if (presensi == 0) {
    return 'Belum Presensi';
  } else if (presensi == 1) {
    return 'Sudah Presensi';
  } else if (presensi == 2) {
    return 'Tidak Hadir';
  } else {
    return 'Status Presensi Tidak Valid';
  }
}

String getJAD_ID_JADWAL(int JAD_ID_JADWAL) {
  if (JAD_ID_JADWAL == 0) {
    return 'Tidak Digantikan';
  } else {
    return 'Digantikan';
  }
}

String GetSesiTetx(int sesi) {
  if (sesi == 0) {
    return 'Pukul 06:00 - 08:00';
  } else if (sesi == 1) {
    return 'Pukul 08:00 - 10:00';
  } else if (sesi == 2) {
    return 'Pukul 10:00 - 12:00';
  } else if (sesi == 3) {
    return 'Pukul 12:00 - 14:00';
  } else if (sesi == 4) {
    return 'Pukul 14:00 - 16:00';
  } else if (sesi == 5) {
    return 'Pukul 18:00 - 20:00';
  } else {
    return 'Pukul 20:00 - 22:00';
  }
}

String GetHariJadwalhariaj(int HARI_JADWAL_HARIAN) {
  if (HARI_JADWAL_HARIAN == 0) {
    return 'Senin';
  } else if (HARI_JADWAL_HARIAN == 1) {
    return 'Selasa';
  } else if (HARI_JADWAL_HARIAN == 2) {
    return 'Rabu';
  } else if (HARI_JADWAL_HARIAN == 3) {
    return 'Kamis';
  } else if (HARI_JADWAL_HARIAN == 4) {
    return 'Jumat';
  } else if (HARI_JADWAL_HARIAN == 5) {
    return 'Sabtu';
  } else {
    return 'Minggu';
  }
}
