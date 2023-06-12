import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http_package;

import '../../../Bloc/login/login_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Config/global.dart';

final http.Client httpClient = http.Client();

class BookingKelasPage extends StatefulWidget {
  @override
  _BookingKelasPageState createState() => _BookingKelasPageState();
}

class _BookingKelasPageState extends State<BookingKelasPage> {
  static String get baseUrl => url;
  List<dynamic> daftarKelasBelumDibook = [];
  late String loggedInUserID;
  List<dynamic> historyBookingKelas = [];
  List<String>? idJadwalHarian; // Nullable list
  List<String>? JsonDataCreate;

  final http_package.Client httpPackageClient = http_package.Client();

  @override
  void initState() {
    super.initState();
    loggedInUserID = getLoggedInUserID();
    GetDataKelasNonBook();
    fetchHistoryData();
  }

  String getLoggedInUserID() {
    String? idMember =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_MEMBER;
    return idMember ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/ShowBookingByIDMEMBER/$loggedInUserID';
    // inspect(apiUrl);
    try {
      var response = await http_package.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null) {
          setState(() {
            historyBookingKelas = List.from(jsonData['data']);
            idJadwalHarian = historyBookingKelas
                .map<String>((item) => item['ID_JADWAL_HARIAN'] as String)
                .toList();
            GetDataKelasNonBook();
          });
        }
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> GetDataKelasNonBook() async {
    final String apiUrl = '$url/GetJadwalHarianBelumdiBook';
    try {
      http_package.Response response = await httpPackageClient.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        // Use the updated idJadwalHarian from fetchHistoryData
        body: json.encode({'ID_JADWAL_HARIAN': idJadwalHarian ?? []}),
      );
      // inspect(response.statusCode);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          setState(() {
            daftarKelasBelumDibook = List.from(jsonData['data']);
          });
        }
      } else {
        print('Failed to fetch instruktur data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  bool isTanggalSudahBerlalu(String tanggal) {
    final now = DateTime.now();
    final jadwalTanggal = DateTime.parse(tanggal);
    return jadwalTanggal.isBefore(now);
  }

  Future<void> CreateBooking(dynamic history) async {
    // Ambil data yang diperlukan dari history
    var ID_USER = BlocProvider.of<LoginBloc>(context).state.user?.ID_USER;
    var ID_MEMBER = BlocProvider.of<LoginBloc>(context).state.user?.ID_MEMBER;
    var ID_JADWAL = history['ID_JADWAL'];
    var SESI_BOOKING_KELAS = history['SESI_JADWAL'];
    var TANGGAL_KELAS = history['TANGGAL_JADWAL_HARIAN'];
    var ID_KELAS = history['ID_KELAS'];
    var ID_JADWAL_HARIAN = history['ID_JADWAL_HARIAN'];

    final url = '$baseUrl/CreateBooking';

    try {
      final response = await httpClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'ID_JADWAL': ID_JADWAL,
          'ID_USER': ID_USER,
          'ID_MEMBER': ID_MEMBER,
          'SESI_BOOKING_KELAS': SESI_BOOKING_KELAS,
          'TANGGAL_KELAS': TANGGAL_KELAS,
          'ID_KELAS': ID_KELAS,
          'ID_JADWAL_HARIAN': ID_JADWAL_HARIAN,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Berhasil Melakukan Booking');
      } else {
        print('Gagal Melakukan Booking. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Kelas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Kelas Minggu Ini',
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
            SizedBox(height: 10),
            if (daftarKelasBelumDibook.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: daftarKelasBelumDibook.length,
                  itemBuilder: (context, index) {
                    var history = daftarKelasBelumDibook[index];
                    inspect(history);
                    var NAMA_KELAS = history['NAMA_KELAS'];
                    var HARGA_KELAS = history['HARGA_KELAS'];
                    var SESI_JADWAL = history['SESI_JADWAL'];
                    var SLOT_KELAS = history['SLOT_KELAS'];
                    var KAPASITAS_KELAS = 10 - history['KAPASITAS_KELAS'];

                    var HARI_JADWAL_HARIAN = history['HARI_JADWAL_HARIAN'];
                    var TANGGAL_JADWAL_HARIAN =
                        history['TANGGAL_JADWAL_HARIAN'];
                    var ID_INSTRUKTUR_PENGGANTI =
                        history['ID_INSTRUKTUR_PENGGANTI'] ?? 'Tidak ada';

                    DateTime today = DateTime.now();
                    DateTime tanggalJadwalHarian =
                        DateTime.parse(history['TANGGAL_JADWAL_HARIAN']);
                    DateTime tanggalIzin =
                        tanggalJadwalHarian.subtract(Duration(days: 1));

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
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Tanggal $TANGGAL_JADWAL_HARIAN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    GetHariJadwalhariaj(HARI_JADWAL_HARIAN),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    GetSesiTetx(SESI_JADWAL),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Slot Tersedia: ${SLOT_KELAS - KAPASITAS_KELAS}/$SLOT_KELAS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Harga Kelas: Rp $HARGA_KELAS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Instruktur Pengganti: $ID_INSTRUKTUR_PENGGANTI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Konfirmasi Booking'),
                                            content: Text(
                                                'Apakah Anda yakin ingin melakukan booking kelas ini?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // Tambahkan aksi yang ingin Anda lakukan saat tombol "Ya" ditekan
                                                  CreateBooking(history);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Ya'),
                                              ),
                                              // TextButton(
                                              //   onPressed: () {
                                              //     // Tambahkan aksi yang ingin Anda lakukan saat tombol "Ya" ditekan
                                              //     CreateBooking(history);
                                              //     Navigator.of(context).pop();
                                              //   },
                                              //   child: Text('Ya'),
                                              // ),
                                              TextButton(
                                                onPressed: () {
                                                  // Tambahkan aksi yang ingin Anda lakukan saat tombol "Tidak" ditekan
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Tidak'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (daftarKelasBelumDibook.isEmpty)
              Text('Tidak ada kelas tersedia'),
          ],
        ),
      ),
    );
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
    return 'Hari Senin';
  } else if (HARI_JADWAL_HARIAN == 1) {
    return 'Hari Selasa';
  } else if (HARI_JADWAL_HARIAN == 2) {
    return 'Hari Rabu';
  } else if (HARI_JADWAL_HARIAN == 3) {
    return 'Hari Kamis';
  } else if (HARI_JADWAL_HARIAN == 4) {
    return 'Hari Jumat';
  } else if (HARI_JADWAL_HARIAN == 5) {
    return 'Hari Sabtu';
  } else {
    return 'Hari Minggu';
  }
}
