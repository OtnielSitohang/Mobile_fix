import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/list_ijin.dart';
import 'package:http/http.dart' as http;

import '../../Bloc/login/login_bloc.dart';
import '../../Config/global.dart';

class KelasMingguanInstruktur extends StatefulWidget {
  const KelasMingguanInstruktur({Key? key}) : super(key: key);

  @override
  State<KelasMingguanInstruktur> createState() =>
      _KelasMingguanInstrukturState();
}

class _KelasMingguanInstrukturState extends State<KelasMingguanInstruktur> {
  static String get baseUrl => url;
  static const String apiEndpoint = '/ijininstruktur/create';
  TextEditingController keteranganController = TextEditingController();
  List<dynamic> historyData = [];
  List<dynamic> instrukturData =
      []; // Tambahkan variabel untuk menyimpan data instruktur
  Map<String, dynamic>? selectedInstruktur;
  // String?
  //     selectedInstruktur; // Tambahkan variabel untuk menyimpan instruktur yang dipilih
  late String loggedInUserID;

  @override
  void initState() {
    super.initState();
    loggedInUserID = getLoggedInUserID();
    fetchHistoryData();
    fetchInstrukturData(); // Panggil fungsi untuk mengambil data instruktur
  }

  String getLoggedInUserID() {
    String? ID_INSTRUKTUR =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_INSTRUKTUR;
    return ID_INSTRUKTUR ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/GetJadwalByIns/$loggedInUserID';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null) {
          setState(() {
            historyData = List.from(jsonData['data']);
          });
        }
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> fetchInstrukturData() async {
    String apiUrl = '$url/cekInstrukturPengganti/$loggedInUserID';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          setState(() {
            instrukturData = List.from(jsonData);
            // inspect(instrukturData);
          });
        }
      } else {
        print('Failed to fetch instruktur data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> sendIzinDataToBackend(
      String keterangan,
      Map<String, dynamic>? selectedInstruktur,
      Map<String, dynamic> history) async {
    final url = '$baseUrl$apiEndpoint';

    final Map<String, dynamic> requestData = {
      'ID_INSTRUKTUR': history['ID_INSTRUKTUR'],
      'INS_ID_USER': history['ID_USER'],
      'ID_INSTRUKTUR_PENGGANTI': selectedInstruktur?['ID_INSTRUKTUR'],
      'INS_PENGGANTI_ID_USER': selectedInstruktur?['ID_USER'],
      'ID_JADWAL': history['ID_JADWAL'],
      'TANGGAL_IZIN': history['TANGGAL_JADWAL_HARIAN'],
      'SESI_IZIN': history['SESI_JADWAL'],
      'KETERANGAN_IZIN': keterangan,
      // 'STATUS_IZIN': 1,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      print(response.body);
      if (response.statusCode == 200) {
        print('Data berhasil dikirim ke backend');
      } else {
        print('Gagal mengirim data ke backend. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Instruktur'),
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
                        'Kelas Anda Minggu Ini',
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
              historyData.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: historyData.length,
                        itemBuilder: (context, index) {
                          var history = historyData[index];
                          var SESI_JADWAL = history['SESI_JADWAL'];
                          var NAMA_KELAS = history['NAMA_KELAS'];
                          var SLOT_KELAS = 10 - history['SLOT_KELAS'];
                          var ID_JADWAL = history['ID_JADWAL'];
                          var bookings = history['kelas']?['BOOKINGS'] as List<
                              dynamic>?; // Assuming the bookings are stored in a list
                          var bookingCount = bookings?.length ?? 0;

                          var HARI_JADWAL_HARIAN =
                              history['HARI_JADWAL_HARIAN'];
                          var TANGGAL_JADWAL_HARIAN =
                              history['TANGGAL_JADWAL_HARIAN'];
                          var ID_INSTRUKTUR_PENGGANTI =
                              history['ID_INSTRUKTUR_PENGGANTI'];

                          DateTime today = DateTime.now();
                          DateTime tanggalJadwalHarian =
                              DateTime.parse(history['TANGGAL_JADWAL_HARIAN']);
                          DateTime tanggalIzin =
                              tanggalJadwalHarian.subtract(Duration(days: 1));

                          bool isButtonDisabled = (ID_INSTRUKTUR_PENGGANTI !=
                                  null ||
                              today.isAfter(tanggalIzin) ||
                              today.difference(tanggalJadwalHarian).inDays > 1);

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          NAMA_KELAS,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          TANGGAL_JADWAL_HARIAN.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          GetHariJadwalhariaj(
                                              HARI_JADWAL_HARIAN),
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
                                          getInstrukturPenggantiText(history),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          getIzinText(history),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: isButtonDisabled
                                                  ? null
                                                  : () {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext
                                                                    context,
                                                                StateSetter
                                                                    setState) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Ajukan Izin'),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Text(
                                                                        'Pilih Instruktur:'),
                                                                    DropdownButton<
                                                                        Map<String,
                                                                            dynamic>>(
                                                                      value:
                                                                          selectedInstruktur,
                                                                      onChanged: (Map<
                                                                              String,
                                                                              dynamic>?
                                                                          newValue) {
                                                                        setState(
                                                                            () {
                                                                          selectedInstruktur =
                                                                              newValue;
                                                                        });
                                                                      },
                                                                      items: instrukturData
                                                                          .map(
                                                                              (instruktur) {
                                                                        return DropdownMenuItem<
                                                                            Map<String,
                                                                                dynamic>>(
                                                                          value:
                                                                              instruktur,
                                                                          child:
                                                                              Text(instruktur['NAMA_USER'] ?? ''),
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            16),
                                                                    TextField(
                                                                      controller:
                                                                          keteranganController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Keterangan Izin',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      String
                                                                          keterangan =
                                                                          keteranganController
                                                                              .text;
                                                                      sendIzinDataToBackend(
                                                                        keterangan,
                                                                        selectedInstruktur,
                                                                        history,
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                        'Kirim'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        'Batal'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                              child: Text('Ajukan Izin'),
                                            )
                                          ],
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
                          'Kelas Anda Masih Kosong',
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListIzinInstruktur(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list),
              Text(
                'Daftar Izin',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
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

String getInstrukturPenggantiText(dynamic history) {
  String? idInstrukturPengganti = history['ID_INSTRUKTUR_PENGGANTI'];

  if (idInstrukturPengganti != null && idInstrukturPengganti.isNotEmpty) {
    return 'Instruktur Pengganti: $idInstrukturPengganti';
  } else {
    return 'Tidak ada perubahan instruktur';
  }
}

String getIzinText(dynamic history) {
  int izinStatus = history['IZIN'] ?? 0;
  switch (izinStatus) {
    case 0:
      return '';
    case 1:
      return 'Status Izin: Diajukan';
    case 2:
      return 'Status Izin: Diterima';
    case 3:
      return 'Status Izin: Ditolak';
    default:
      return '';
  }
}
