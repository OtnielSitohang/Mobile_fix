import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../Config/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http_package;
// import 'package:http/http.dart' as http_package;

class HomeManager extends StatefulWidget {
  const HomeManager({super.key});

  @override
  State<HomeManager> createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  List<dynamic> daftarKelasMingguIni = [];
  static String get baseUrl => url;
  // bool isMulaiPressed = false;
  // bool isSelesaiPressed = false;
  String? ID_JADWAL_HARIAN;

  @override
  void initState() {
    super.initState();
    getDataKelasNonBook();
    updateJamMulai(ID_JADWAL_HARIAN);
    UpdateJadwalSelesai(ID_JADWAL_HARIAN);
  }

  Future<void> getDataKelasNonBook() async {
    String apiUrl = '$url/getDataHariini';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          setState(() {
            daftarKelasMingguIni = List.from(jsonData['data']);
          });
        } else {
          print('Failed to fetch data or invalid response');
        }
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> updateJamMulai(String? idJadwalHarian) async {
    final url = '$baseUrl/UpdateJadwalMulai/$idJadwalHarian';
    inspect(url);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.body);
      inspect(response.statusCode);
      if (response.statusCode == 200) {
        print('Data Berhasil di Update');
        setState(() {
          // isMulaiPressed = true;
        });
      } else {
        print('Data Gagal di Update. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> UpdateJadwalSelesai(String? idJadwalHarian) async {
    final url = '$baseUrl/UpdateJadwalSelesai/$idJadwalHarian';
    inspect(url);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.body);
      inspect(response.statusCode);
      if (response.statusCode == 200) {
        print('Data Berhasil di Update');
        setState(() {
          // isMulaiPressed = true;
        });
      } else {
        print('Data Gagal di Update. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome To Gofit'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Daftar Kelas Hari Ini',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Visibility(
            visible: daftarKelasMingguIni.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                itemCount: daftarKelasMingguIni.length,
                itemBuilder: (context, index) {
                  var item = daftarKelasMingguIni[index];
                  var namaKelas = item['NAMA_KELAS'];
                  var idJadwalHarian = item['ID_JADWAL_HARIAN'];
                  var slotKelas = 10 - item['SLOT_KELAS'];
                  var namaUser = item['NAMA_USER'];
                  var sesiJadwal = item['SESI_JADWAL'];
                  var WAKTU_MULAI =
                      item['WAKTU_MULAI'] ?? 'Kelas Belum di Mulai';
                  var waktuMulai = item['WAKTU_MULAI'];
                  var waktuSelesai = item['WAKTU_SELESAI'];
                  var WAKTU_SELESAI =
                      item['WAKTU_SELESAI'] ?? 'Kelas Belum Diselesaikan';

                  bool isMulaiDisabled = waktuMulai != null;
                  bool isSelesaiDisabled =
                      waktuSelesai != null || waktuMulai == null;

                  bool isKelasComplete = isMulaiDisabled && isSelesaiDisabled;

                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  'Nama Kelas $namaKelas',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Instruktur $namaUser',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Kapasitas Kelas $slotKelas',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Sesi Kelas ${GetSesiTetx(sesiJadwal)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Start : $WAKTU_MULAI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Selesai : $WAKTU_SELESAI',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: isMulaiDisabled
                                              ? null
                                              : () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Konfirmasi Mulai'),
                                                        content:
                                                            Text('Mulai Kelas'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              // Close the dialog
                                                            },
                                                            child:
                                                                Text('Batal'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                                await updateJamMulai(
                                                                    idJadwalHarian);
                                                                _showSnackBar(
                                                                    context,
                                                                    'Berhasil Memulai Kelas');
                                                              } catch (error) {
                                                                print(
                                                                    'Error: $error');
                                                              }
                                                            },
                                                            child: Text('Ya'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                          child: Text('Mulai'),
                                        ),
                                        SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: isSelesaiDisabled
                                              ? null
                                              : () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Konfirmasi Selesai'),
                                                        content: Text(
                                                            'Apakah Anda yakin ingin mengakhiri kelas?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              // Close the dialog
                                                            },
                                                            child:
                                                                Text('Batal'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                // Close the dialog
                                                                await UpdateJadwalSelesai(
                                                                    idJadwalHarian);
                                                                setState(() {
                                                                  // isSelesaiPressed = true;
                                                                  _showSnackBar(
                                                                      context,
                                                                      'Berhasil Mengakhiri Kelas');
                                                                });
                                                              } catch (error) {
                                                                print(
                                                                    'Error: $error');
                                                              }
                                                            },
                                                            child: Text('Ya'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                          child: Text('Selesai'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (isKelasComplete)
                                  if (isKelasComplete)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Kelas Complete',
                                        style: TextStyle(
                                          color: Colors.white,
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
          ),
          Visibility(
            visible: daftarKelasMingguIni.isEmpty,
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
                    colors: [Colors.red.shade200, Colors.red.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Kelas Hari Masih Kosong',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
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

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
