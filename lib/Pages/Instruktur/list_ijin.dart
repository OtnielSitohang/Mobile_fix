import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';
import 'package:http/http.dart' as http;

import '../../Config/global.dart';

class ListIzinInstruktur extends StatefulWidget {
  const ListIzinInstruktur({Key? key}) : super(key: key);

  @override
  State<ListIzinInstruktur> createState() => _ListIzinInstrukturState();
}

class _ListIzinInstrukturState extends State<ListIzinInstruktur> {
  late String loggedInUserID;
  List<dynamic> historyData = [];

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
    String apiUrl = '$url/showIzinByID/$loggedInUserID';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Izin'),
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
                      'Daftar Izin Anda',
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
            SizedBox(
              height: 10,
            ),
            historyData.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: historyData.length,
                      itemBuilder: (context, index) {
                        var history = historyData[index];
                        var jumlahData = history['jumlahData'];
                        var ID_INSTRUKTUR_PENGGANTI =
                            history['instruktur_pengganti']['ID_INSTRUKTUR'];
                        var NAMA_USER_PENGGANTI =
                            history['instruktur_pengganti_user_name']
                                ['NAMA_USER'];
                        var TANGGAL_IZIN = history['TANGGAL_IZIN'];
                        var TANGGAL_PENGAJUAN_IZIN =
                            history['TANGGAL_PENGAJUAN_IZIN'];
                        var KETERANGAN_IZIN = history['KETERANGAN_IZIN'];
                        var STATUS_IZIN = history['STATUS_IZIN'];
                        var NAMA_KELAS = history['NAMA_KELAS'];
                        inspect(history);

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
                                        'Kelas $NAMA_KELAS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Pada  $TANGGAL_IZIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Digantikan Oleh $NAMA_USER_PENGGANTI',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Izin Diajukan Pada  $TANGGAL_PENGAJUAN_IZIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Dengan Keterangan  $KETERANGAN_IZIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        getIzinText(STATUS_IZIN),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
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
                        'Anda Belum Pernah Izin',
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
    );
  }
}

String getIzinText(STATUS_IZIN) {
  switch (STATUS_IZIN) {
    case 0:
      return 'Status Izin Belum di Konfirmasi';
    case 1:
      return 'Status Izin Dikonfirmasi';
    case 2:
      return 'Status Izin  Ditolak';
    default:
      return '';
  }
}
